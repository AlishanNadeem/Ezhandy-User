import 'dart:convert';

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class ServiceSelectionController extends GetxController {
  ServiceSelectionController({required this.providerId});

  final String? providerId;

  Set<String> excludedProviderServiceIds = {};
  int? excludedServiceTypeId;
  String? excludedServiceLabel;

  final RxBool isLoadingProviderServices = false.obs;
  final RxList<Map<String, dynamic>> providerServices =
      <Map<String, dynamic>>[].obs;

  void syncExclusions({
    Set<String>? excludedProviderServiceIds,
    int? excludedServiceTypeId,
    String? excludedServiceLabel,
  }) {
    this.excludedProviderServiceIds =
        Set<String>.from(excludedProviderServiceIds ?? const {});
    this.excludedServiceTypeId = excludedServiceTypeId;
    this.excludedServiceLabel = excludedServiceLabel;
  }

  List<Map<String, dynamic>> get secondaryProviderServices => providerServices
      .where((service) => !_isExcludedService(service))
      .toList();

  List<String> get secondaryServiceLabels =>
      secondaryProviderServices.map(serviceDropdownLabel).toList();

  Map<String, dynamic>? findSecondaryServiceByLabel(String? label) {
    final trimmed = label?.trim() ?? '';
    if (trimmed.isEmpty) return null;

    for (final service in secondaryProviderServices) {
      if (serviceDropdownLabel(service) == trimmed) return service;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final id = providerId?.trim() ?? '';
    if (id.isEmpty) {
      providerServices.clear();
      return;
    }

    isLoadingProviderServices.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.userDetailsById(id),
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            providerServices.assignAll(_parseProviderServices(res));
          },
          onFailureCallback: (_) => providerServices.clear(),
        ),
      );
    } finally {
      isLoadingProviderServices.value = false;
    }
  }

  static List<Map<String, dynamic>> _parseProviderServices(dynamic response) {
    final payload = _parseProfilePayload(response);
    if (payload == null) return [];

    final list = payload['providerServices'] ?? payload['ProviderServices'];
    if (list is! List) return [];

    return list
        .map((item) {
          if (item is Map<String, dynamic>) return item;
          if (item is Map) return Map<String, dynamic>.from(item);
          return <String, dynamic>{};
        })
        .where((item) => item.isNotEmpty)
        .toList();
  }

  /// `{ isSuccess, data: { userDetails, certifications[], providerServices[] } }`
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

  bool _isExcludedService(Map<String, dynamic> service) {
    final excludedIds = excludedProviderServiceIds;

    final providerServiceId = _providerServiceId(service);
    if (providerServiceId != null && excludedIds.contains(providerServiceId)) {
      return true;
    }

    final serviceTypeId = _resolveServiceTypeId(service);
    if (excludedServiceTypeId != null &&
        serviceTypeId != null &&
        serviceTypeId == excludedServiceTypeId) {
      return true;
    }

    final excludedLabel = excludedServiceLabel?.trim() ?? '';
    if (excludedLabel.isNotEmpty && serviceLabel(service) == excludedLabel) {
      return true;
    }

    return false;
  }

  static int? resolveServiceId(Map<String, dynamic>? service) {
    if (service == null) return null;

    final providerServiceId = _providerServiceId(service);
    if (providerServiceId != null) {
      final parsed = int.tryParse(providerServiceId);
      if (parsed != null) return parsed;
    }

    for (final key in ['id', 'providerServiceId', 'serviceId']) {
      final value = service[key];
      if (value is int) return value;
      final parsed = int.tryParse(value?.toString() ?? '');
      if (parsed != null) return parsed;
    }

    return null;
  }

  static String? _providerServiceId(Map<String, dynamic> service) {
    for (final key in ['id', 'providerServiceId', 'provider_service_id']) {
      final value = service[key];
      if (value == null) continue;
      final id = value.toString().trim();
      if (id.isNotEmpty) return id;
    }
    return null;
  }

  static int? _resolveServiceTypeId(Map<String, dynamic> service) {
    for (final key in ['serviceTypeId', 'service_type_id', 'ServiceTypeId']) {
      final value = service[key];
      if (value is int) return value;
      final parsed = int.tryParse(value?.toString() ?? '');
      if (parsed != null) return parsed;
    }

    final serviceType = service['serviceType'];
    if (serviceType is Map) {
      for (final key in ['id', 'Id', 'serviceTypeId']) {
        final value = serviceType[key];
        if (value is int) return value;
        final parsed = int.tryParse(value?.toString() ?? '');
        if (parsed != null) return parsed;
      }
    }

    return null;
  }

  static String serviceLabel(Map<String, dynamic> service) {
    final title = service['title']?.toString().trim() ?? '';
    if (title.isNotEmpty) return title;

    final serviceType = service['serviceType'];
    if (serviceType is Map) {
      final name = serviceType['name']?.toString().trim() ?? '';
      if (name.isNotEmpty) return name;
    }

    return 'Service';
  }

  static String serviceDropdownLabel(Map<String, dynamic> service) {
    final name = serviceLabel(service);
    final rate = _formatHourlyRate(_parseHourlyRate(service));
    return '$name - $rate per hour';
  }

  static double _parseHourlyRate(Map<String, dynamic> service) {
    final value = service['hourlyRate'];
    if (value == null) return 0;
    final cleaned = value.toString().replaceAll(RegExp(r'[^\d.-]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  static String _formatHourlyRate(double amount) {
    if (amount == amount.roundToDouble()) {
      return '\$${amount.toInt()}';
    }
    return '\$${amount.toStringAsFixed(2)}';
  }
}
