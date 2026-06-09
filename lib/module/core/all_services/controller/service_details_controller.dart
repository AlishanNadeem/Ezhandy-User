import 'dart:convert';
import 'dart:developer' as developer;

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/all_services/model/provider_service_detail_model.dart';
import 'package:ezhandy_user/module/core/booking/model/active_booking_check_model.dart';
import 'package:ezhandy_user/utils/favorite_status_parser.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class ServiceDetailsController extends GetxController {
  ServiceDetailsController({
    required this.providerServiceId,
    this.providerId,
  });

  /// Provider-service row id for `provider/{id}` and `favourites/services/{id}`.
  final String providerServiceId;
  final String? providerId;

  final RxBool isLoading = false.obs;
  final Rxn<ProviderServiceDetailModel> detail =
      Rxn<ProviderServiceDetailModel>();
  final RxBool isServiceFavorite = false.obs;
  final RxBool isServiceFavoriteToggling = false.obs;
  final RxBool isCheckingActiveBooking = false.obs;
  final RxBool hasActiveBooking = false.obs;
  final Rxn<ActiveBookingCheckResult> activeBookingCheck =
      Rxn<ActiveBookingCheckResult>();

  bool get canCheckActiveBooking {
    final pid = providerId?.trim() ?? '';
    return providerServiceId.trim().isNotEmpty && pid.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();
    if (providerServiceId.isNotEmpty) {
      fetchProviderDetail();
      fetchFavoriteStatus();
    }
    if (canCheckActiveBooking) {
      fetchActiveBookingCheck();
    }
  }

  Future<void> fetchProviderDetail() async {
    if (providerServiceId.isEmpty) return;

    isLoading.value = true;

    final endpoint = NetworkStrings.providerServiceDetail(providerServiceId);
    developer.log(
      'GET $endpoint',
      name: 'ServiceDetailsController',
    );

    final response = await DioClient().getRequest(
      endPoint: endpoint,
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (r) {
          _logProviderDetailResponse(endpoint, r);
          final data = r is Map ? r['data'] : null;
          if (data is Map<String, dynamic>) {
            detail.value = ProviderServiceDetailModel.fromJson(data);
          } else if (data is Map) {
            detail.value =
                ProviderServiceDetailModel.fromJson(Map<String, dynamic>.from(data));
          } else {
            detail.value = null;
          }
        },
        onFailureCallback: (r) {
          developer.log(
            'provider detail failed: $r',
            name: 'ServiceDetailsController',
          );
          detail.value = null;
        },
      ),
    );

    isLoading.value = false;
  }

  void _logProviderDetailResponse(String endpoint, dynamic response) {
    try {
      final body = const JsonEncoder.withIndent('  ').convert(response);
      developer.log(
        'GET $endpoint — full response:\n$body',
        name: 'ServiceDetailsController',
      );
    } catch (_) {
      developer.log(
        'GET $endpoint — full response:\n$response',
        name: 'ServiceDetailsController',
      );
    }
  }

  Future<void> fetchFavoriteStatus() async {
    if (providerServiceId.isEmpty) return;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.favouriteServiceStatus(providerServiceId),
      isHeaderRequire: true,
      isLoader: false,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (r) {
          isServiceFavorite.value = parseFavoriteStatusPayload(r);
        },
        onFailureCallback: (_) {
          isServiceFavorite.value = false;
        },
      ),
    );
  }

  Future<void> fetchActiveBookingCheck() async {
    if (!canCheckActiveBooking) return;

    isCheckingActiveBooking.value = true;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.checkActiveBooking(
        providerServiceId: providerServiceId.trim(),
        providerId: providerId!.trim(),
      ),
      isHeaderRequire: true,
      isLoader: false,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (r) {
          final data = r is Map ? r['data'] : null;
          if (data is Map<String, dynamic>) {
            final result = ActiveBookingCheckResult.fromJson(data);
            activeBookingCheck.value = result;
            hasActiveBooking.value = result.hasActive;
          } else if (data is Map) {
            final result = ActiveBookingCheckResult.fromJson(
              Map<String, dynamic>.from(data),
            );
            activeBookingCheck.value = result;
            hasActiveBooking.value = result.hasActive;
          } else {
            activeBookingCheck.value = null;
            hasActiveBooking.value = false;
          }
        },
        onFailureCallback: (_) {
          activeBookingCheck.value = null;
          hasActiveBooking.value = false;
        },
      ),
    );

    isCheckingActiveBooking.value = false;
  }

  Future<void> toggleServiceFavorite() async {
    if (providerServiceId.isEmpty) return;
    if (isServiceFavoriteToggling.value) return;

    final wasFavorite = isServiceFavorite.value;
    final endpoint = NetworkStrings.favouriteService(providerServiceId);

    isServiceFavoriteToggling.value = true;
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
            isServiceFavorite.value = !wasFavorite;
          },
          onFailureCallback: (_) {},
        ),
      );
    } finally {
      isServiceFavoriteToggling.value = false;
    }
  }
}
