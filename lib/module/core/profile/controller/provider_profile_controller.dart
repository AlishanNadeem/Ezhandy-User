import 'dart:convert';

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/favorite_status_parser.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class ProviderProfileController extends GetxController {
  ProviderProfileController({required this.providerId});

  final String? providerId;

  final Rxn<Map<String, dynamic>> profileData = Rxn<Map<String, dynamic>>();
  final RxBool isLoading = false.obs;
  final RxBool isProviderFavorite = false.obs;
  final RxBool isFavoriteToggling = false.obs;

  /// Favourite state per provider-service API id (`providerServices[].id`).
  final RxMap<String, bool> serviceFavoriteById = <String, bool>{}.obs;
  final Rxn<String> serviceFavoriteTogglingId = Rxn<String>();

  Map<String, dynamic>? get userDetails {
    final d = profileData.value;
    if (d == null) return null;
    final u = d['userDetails'];
    if (u is Map<String, dynamic>) return u;
    if (u is Map) return Map<String, dynamic>.from(u);
    return null;
  }

  List<dynamic> get providerServices {
    final d = profileData.value;
    if (d == null) return const [];
    dynamic list = d['providerServices'] ?? d['ProviderServices'];
    if (list is List) return List<dynamic>.from(list);
    return const [];
  }

  /// API: `certifications: [{ institutionName, certificationTitle, ... }]`.
  List<dynamic> get certifications {
    final d = profileData.value;
    if (d == null) return const [];
    dynamic list = d['certifications'] ?? d['Certifications'];
    if (list == null) {
      final u = userDetails;
      list = u?['certifications'] ?? u?['Certifications'];
    }
    if (list is List) return List<dynamic>.from(list);
    if (list is Map) return [Map<String, dynamic>.from(list)];
    return const [];
  }

  /// Id for `favourites/services/{id}` from a `providerServices` element.
  static String? favoriteApiIdForProviderService(Map<String, dynamic> service) {
    for (final key in ['id', 'providerServiceId', 'provider_service_id']) {
      final v = service[key];
      if (v == null) continue;
      final s = v.toString().trim();
      if (s.isNotEmpty) return s;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
    fetchFavoriteStatus();
  }

  Future<void> fetchUserDetails() async {
    if (providerId == null || providerId!.trim().isEmpty) {
      profileData.value = null;
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.userDetailsById(providerId!.trim()),
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (response) {
          profileData.value = _parseProfilePayload(response);
          serviceFavoriteById.clear();
          prefetchAllServiceFavoriteStatuses();
          isLoading.value = false;
        },
        onFailureCallback: (_) {
          profileData.value = null;
          serviceFavoriteById.clear();
          isLoading.value = false;
        },
      ),
    );
    isLoading.value = false;
  }

  /// `{ isSuccess, data: { userDetails, certifications[], providerServices[] } }`
  /// or inner object only / string JSON / nested `data.data`.
  static Map<String, dynamic>? _parseProfilePayload(dynamic response) {
    dynamic apiData = response is Map ? response['data'] : null;
    if (apiData is String) {
      try {
        apiData = jsonDecode(apiData);
      } catch (_) {
        apiData = null;
      }
    }
    if (apiData == null &&
        response is Map &&
        response['userDetails'] != null) {
      apiData = response;
    }
    final payload = apiData is Map && apiData['data'] != null
        ? apiData['data']
        : apiData;
    if (payload is! Map) return null;
    return Map<String, dynamic>.from(payload);
  }

  Future<void> fetchFavoriteStatus() async {
    if (providerId == null || providerId!.trim().isEmpty) return;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.favouriteProviderStatus(providerId!.trim()),
      isHeaderRequire: true,
      isLoader: false,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (r) {
          isProviderFavorite.value = parseFavoriteStatusPayload(r);
        },
        onFailureCallback: (_) {
          isProviderFavorite.value = false;
        },
      ),
    );
  }

  Future<void> toggleProviderFavorite() async {
    if (providerId == null || providerId!.trim().isEmpty) return;
    if (isFavoriteToggling.value) return;

    final id = providerId!.trim();
    final wasFavorite = isProviderFavorite.value;
    final endpoint = NetworkStrings.favouriteProvider(id);

    isFavoriteToggling.value = true;
    try {
      final response = wasFavorite
          ? await DioClient().deleteRequest(
              endPoint: endpoint,
              isHeaderRequire: true,
              isLoader: false,
            )
          : await DioClient().postRequest(
              endPoint: endpoint,
              isHeaderRequire: true,
              data: <String, dynamic>{},
              isLoader: false,
            );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (_) {
            isProviderFavorite.value = !wasFavorite;
          },
          onFailureCallback: (_) {},
        ),
      );
    } finally {
      isFavoriteToggling.value = false;
    }
  }

  void prefetchAllServiceFavoriteStatuses() {
    for (final raw in providerServices) {
      final m = raw is Map<String, dynamic>
          ? raw
          : (raw is Map ? Map<String, dynamic>.from(raw) : null);
      if (m == null) continue;
      final id = favoriteApiIdForProviderService(m);
      if (id != null) {
        fetchServiceFavoriteStatus(id);
      }
    }
  }

  Future<void> fetchServiceFavoriteStatus(String apiServiceId) async {
    if (apiServiceId.isEmpty) return;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.favouriteServiceStatus(apiServiceId),
      isHeaderRequire: true,
      isLoader: false,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (r) {
          serviceFavoriteById[apiServiceId] = parseFavoriteStatusPayload(r);
        },
        onFailureCallback: (_) {
          serviceFavoriteById[apiServiceId] = false;
        },
      ),
    );
  }

  Future<void> toggleServiceFavorite(String apiServiceId) async {
    if (apiServiceId.isEmpty) return;
    if (serviceFavoriteTogglingId.value != null) return;

    final wasFavorite = serviceFavoriteById[apiServiceId] ?? false;
    final endpoint = NetworkStrings.favouriteService(apiServiceId);

    serviceFavoriteTogglingId.value = apiServiceId;
    try {
      final response = wasFavorite
          ? await DioClient().deleteRequest(
              endPoint: endpoint,
              isHeaderRequire: true,
              isLoader: false,
            )
          : await DioClient().postRequest(
              endPoint: endpoint,
              isHeaderRequire: true,
              data: <String, dynamic>{},
              isLoader: false,
            );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (_) {
            serviceFavoriteById[apiServiceId] = !wasFavorite;
          },
          onFailureCallback: (_) {},
        ),
      );
    } finally {
      serviceFavoriteTogglingId.value = null;
    }
  }
}
