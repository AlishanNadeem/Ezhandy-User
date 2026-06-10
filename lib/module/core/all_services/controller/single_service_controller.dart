import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/local_search_helper.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class SingleServiceController extends GetxController {
  SingleServiceController({required this.serviceId, required this.isQuick});

  final int? serviceId;
  final bool isQuick;

  final RxList<dynamic> freelancersList = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  List<dynamic> get filteredFreelancersList => filterListByTitle<dynamic>(
        items: freelancersList,
        query: searchQuery.value,
        titleOf: displayNameFromUserPayload,
      );

  void updateSearch(String value) => searchQuery.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchFreelancers();
  }

  Future<void> fetchFreelancers() async {
    if (serviceId == null) {
      freelancersList.clear();
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.freelancersByServiceId(serviceId!),
      isHeaderRequire: true,
      isLoader: false,
      queryParameters: {'isQuick': isQuick},
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: _FreelancersListener(
        onSuccessCallback: (response) {
          final outer = response?['data'];
          // Some endpoints nest list under data.data; yours uses data.userDetails + data.providerServices.
          final raw = outer is Map && outer['data'] != null
              ? outer['data']
              : outer;
          if (raw is List) {
            final rows = <dynamic>[];
            for (final item in raw) {
              rows.addAll(_expandProviderPayload(item));
            }
            freelancersList.assignAll(rows);
          } else if (raw is Map) {
            freelancersList.assignAll(_expandProviderPayload(raw));
          } else {
            freelancersList.clear();
          }
          isLoading.value = false;
        },
        onFailureCallback: (_) {
          freelancersList.clear();
          isLoading.value = false;
        },
      ),
    );
    isLoading.value = false;
  }

  /// One API row: `{ userDetails, certifications, providerServices[] }`.
  /// UI gets one card per [providerServices] entry matching [serviceId] (serviceTypeId).
  List<Map<String, dynamic>> _expandProviderPayload(dynamic item) {
    final map = _asStringKeyedMap(item);
    if (map == null) return [];

    final userDetails = map['userDetails'];
    if (userDetails == null) {
      // Flat API row: profileImage, fullName, serviceTitle, etc. on one object.
      final flat = Map<String, dynamic>.from(map);
      return [
        <String, dynamic>{
          'userDetails': flat,
          'certifications':
              flat['certifications'] is List ? flat['certifications'] : [],
          'providerServices': <dynamic>[
            <String, dynamic>{
              'id': flat['serviceId'],
              'title': flat['serviceTitle'],
              'hourlyRate': flat['serviceHourlyRate'] ?? flat['hourlyRate'],
              'rating': flat['rating'],
              'serviceTypeId': flat['serviceTypeId'] ?? serviceId,
              'visitCharges': flat['visitCharges'],
              'description': flat['serviceDescription'],
            },
          ],
        },
      ];
    }

    final userDetailsMap = Map<String, dynamic>.from(
      _asStringKeyedMap(userDetails) ?? <String, dynamic>{},
    );
    _copyProfileImageOntoUser(map, userDetailsMap);

    final certifications = map['certifications'] ?? [];
    final providerServices = map['providerServices'];
    if (providerServices is! List) {
      return [
        <String, dynamic>{
          'userDetails': userDetailsMap,
          'certifications': certifications,
          'providerServices': <dynamic>[],
        },
      ];
    }

    final sid = serviceId;
    final filtered = <Map<String, dynamic>>[];
    for (final ps in providerServices) {
      final p = _asStringKeyedMap(ps);
      if (p == null) continue;
      if (sid != null && !_serviceTypeMatches(p['serviceTypeId'], sid)) {
        continue;
      }
      filtered.add(p);
    }

    if (filtered.isEmpty) return [];

    return filtered
        .map(
          (ps) => <String, dynamic>{
            'userDetails': userDetailsMap,
            'certifications': certifications,
            'providerServices': <dynamic>[ps],
          },
        )
        .toList();
  }

  /// API uses [profileImage] on the user; copy from outer payload when nested userDetails omits it.
  static void _copyProfileImageOntoUser(
    Map<String, dynamic> outer,
    Map<String, dynamic> userDetails,
  ) {
    final nested = userDetails['profileImage']?.toString().trim() ?? '';
    if (nested.isNotEmpty && nested.toLowerCase() != 'null') return;
    final fromOuter = outer['profileImage'];
    if (fromOuter != null) {
      userDetails['profileImage'] = fromOuter;
    }
  }

  static Map<String, dynamic>? _asStringKeyedMap(dynamic v) {
    if (v is Map<String, dynamic>) return v;
    if (v is Map) return Map<String, dynamic>.from(v);
    return null;
  }

  static bool _serviceTypeMatches(dynamic stId, int sid) {
    if (stId is int) return stId == sid;
    return int.tryParse(stId?.toString() ?? '') == sid;
  }
}

class _FreelancersListener extends ResponseListener {
  final void Function(dynamic response) onSuccessCallback;
  final void Function(dynamic response) onFailureCallback;

  _FreelancersListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}
