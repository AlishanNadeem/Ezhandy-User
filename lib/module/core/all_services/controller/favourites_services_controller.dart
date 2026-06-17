import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class FavouritesServicesController extends GetxController {
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> providerItems =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isProvidersLoading = false.obs;
  final Rxn<String> removingServiceId = Rxn<String>();
  final Rxn<String> removingProviderId = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    fetchFavourites();
    fetchFavouriteProviders();
  }

  Future<void> fetchFavourites() async {
    isLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.favouriteServicesListEndpoint,
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (r) {
          final data = r is Map ? r['data'] : null;
          if (data is List) {
            items.assignAll(
              data
                  .map((e) => e is Map<String, dynamic>
                      ? e
                      : Map<String, dynamic>.from(e as Map))
                  .toList(),
            );
          } else {
            items.clear();
          }
          isLoading.value = false;
        },
        onFailureCallback: (_) {
          items.clear();
          isLoading.value = false;
        },
      ),
    );
    isLoading.value = false;
  }

  Future<void> fetchFavouriteProviders() async {
    isProvidersLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.favouriteProvidersListEndpoint,
      isHeaderRequire: true,
      isLoader: false,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (r) {
          final data = r is Map ? r['data'] : null;
          if (data is List) {
            providerItems.assignAll(
              data
                  .map((e) => e is Map<String, dynamic>
                      ? e
                      : Map<String, dynamic>.from(e as Map))
                  .toList(),
            );
          } else {
            providerItems.clear();
          }
          isProvidersLoading.value = false;
        },
        onFailureCallback: (_) {
          providerItems.clear();
          isProvidersLoading.value = false;
        },
      ),
    );
    isProvidersLoading.value = false;
  }

  /// Same id as POST/DELETE `favourites/services/{id}` (provider-service row id).
  static String serviceApiIdFromRow(Map<String, dynamic> row) {
    final service = row['service'];
    if (service is Map) {
      final m = Map<String, dynamic>.from(service);
      final id = m['id']?.toString().trim() ?? '';
      if (id.isNotEmpty) return id;
    }
    return row['serviceId']?.toString().trim() ?? '';
  }

  /// Same id as POST/DELETE `favourites/providers/{id}` (provider user id).
  static String providerApiIdFromRow(Map<String, dynamic> row) {
    final providerId = row['providerId']?.toString().trim() ?? '';
    if (providerId.isNotEmpty) return providerId;

    final provider = row['provider'];
    if (provider is Map) {
      return Map<String, dynamic>.from(provider)['id']?.toString().trim() ?? '';
    }
    return '';
  }

  static Map<String, dynamic> providerMapFromRow(Map<String, dynamic> row) {
    final provider = row['provider'];
    if (provider is Map<String, dynamic>) return provider;
    if (provider is Map) return Map<String, dynamic>.from(provider);
    return <String, dynamic>{};
  }

  Future<void> removeServiceFromFavourites(String serviceApiId) async {
    if (serviceApiId.isEmpty) return;
    if (removingServiceId.value != null) return;

    removingServiceId.value = serviceApiId;
    try {
      final response = await DioClient().deleteRequest(
        endPoint: NetworkStrings.favouriteService(serviceApiId),
        isHeaderRequire: true,
        isLoader: false,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (_) {
            items.removeWhere(
              (row) => serviceApiIdFromRow(row) == serviceApiId,
            );
          },
          onFailureCallback: (_) {},
        ),
      );
    } finally {
      removingServiceId.value = null;
    }
  }

  Future<void> removeProviderFromFavourites(String providerId) async {
    if (providerId.isEmpty) return;
    if (removingProviderId.value != null) return;

    removingProviderId.value = providerId;
    try {
      final response = await DioClient().deleteRequest(
        endPoint: NetworkStrings.favouriteProvider(providerId),
        isHeaderRequire: true,
        isLoader: false,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (_) {
            providerItems.removeWhere(
              (row) => providerApiIdFromRow(row) == providerId,
            );
          },
          onFailureCallback: (_) {},
        ),
      );
    } finally {
      removingProviderId.value = null;
    }
  }
}
