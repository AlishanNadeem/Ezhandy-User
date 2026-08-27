import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/products/model/marketplace_subscription_status.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketplaceSubscriptionController extends GetxController {
  final RxBool isCheckingStatus = false.obs;
  final RxBool isLoadingStatus = false.obs;
  final RxBool isLoadingPlans = false.obs;
  final RxBool isLoadingHistory = false.obs;
  final Rxn<MarketplaceSubscriptionStatus> status =
      Rxn<MarketplaceSubscriptionStatus>();
  final RxList<MarketplaceSubscriptionPlan> plans =
      <MarketplaceSubscriptionPlan>[].obs;
  final RxList<MarketplaceSubscriptionHistoryItem> history =
      <MarketplaceSubscriptionHistoryItem>[].obs;
  final RxnInt selectedPlanId = RxnInt();

  bool get hasActiveSubscription =>
      status.value?.hasActiveSubscription == true;

  MarketplaceSubscriptionPlan? get selectedPlan {
    final id = selectedPlanId.value;
    if (id == null) return null;
    for (final plan in plans) {
      if (plan.id == id) return plan;
    }
    return null;
  }

  void selectPlan(int planId) {
    selectedPlanId.value = planId;
  }

  int? get activePlanId => status.value?.activePlanId;

  bool isCurrentActivePlan(int planId) {
    final activeId = activePlanId;
    return activeId != null && activeId == planId;
  }

  bool get isSelectedPlanAlreadyActive {
    final selected = selectedPlanId.value;
    if (selected == null) return false;
    return isCurrentActivePlan(selected);
  }

  Future<void> loadPlans() async {
    isLoadingPlans.value = true;
    try {
      await fetchStatus(showLoader: false);
      final result = await fetchPlans(showLoader: false);
      plans.assignAll(result);
      if (selectedPlanId.value == null && result.isNotEmpty) {
        final popular = result.where((p) => p.popular).toList();
        selectedPlanId.value =
            popular.isNotEmpty ? popular.first.id : result.first.id;
      }
    } finally {
      isLoadingPlans.value = false;
    }
  }

  Future<bool> ensureCanAddProduct(BuildContext context) async {
    if (isCheckingStatus.value) return false;

    isCheckingStatus.value = true;
    try {
      final result = await fetchStatus(showLoader: true);

      if (!context.mounted) return false;

      if (result == null) {
        AppDialogs.showToast(
          message: AppStrings.unableToCheckMarketplaceSubscription,
        );
        return false;
      }

      status.value = result;

      if (!result.hasActiveSubscription) {
        await AppDialogs.showSuccessDialog(
          context,
          title: AppStrings.subscription,
          description: AppStrings.marketplaceSubscriptionRequiredMessage,
          isDoneShow: false,
          btnTxt1: AppStrings.viewSubscriptions,
          btnTxt2: AppStrings.cancel,
          onTap1: () {
            AppNavigation.navigatorPop(context);
            AppNavigation.navigateTo(
              context,
              AppRoutes.marketplaceSubscriptionPlansScreenRoute,
            );
          },
          onTap2: () => AppNavigation.navigatorPop(context),
        );
        return false;
      }

      if (result.isProductLimitReached) {
        await AppDialogs.showSuccessDialog(
          context,
          title: AppStrings.subscription,
          description: AppStrings.productLimitReachedMessage,
          isDoneShow: false,
          btnTxt1: AppStrings.viewSubscriptions,
          btnTxt2: AppStrings.cancel,
          onTap1: () {
            AppNavigation.navigatorPop(context);
            AppNavigation.navigateTo(
              context,
              AppRoutes.marketplaceSubscriptionPlansScreenRoute,
            );
          },
          onTap2: () => AppNavigation.navigatorPop(context),
        );
        return false;
      }

      return true;
    } finally {
      isCheckingStatus.value = false;
    }
  }

  Future<MarketplaceSubscriptionStatus?> fetchStatus({
    bool showLoader = false,
  }) async {
    isLoadingStatus.value = true;
    MarketplaceSubscriptionStatus? parsed;

    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.marketplaceSubscriptionStatusEndpoint,
        queryParameters: {
          '_': DateTime.now().millisecondsSinceEpoch,
        },
        isHeaderRequire: true,
        isLoader: showLoader,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            parsed = MarketplaceSubscriptionStatus.fromApiResponse(res);
            status.value = parsed;
          },
          onFailureCallback: (_) => parsed = null,
        ),
      );

      return parsed;
    } finally {
      isLoadingStatus.value = false;
    }
  }

  Future<List<MarketplaceSubscriptionPlan>> fetchPlans({
    bool showLoader = true,
  }) async {
    List<MarketplaceSubscriptionPlan> result = const [];

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.marketplaceSubscriptionPlansEndpoint,
      queryParameters: {
        '_': DateTime.now().millisecondsSinceEpoch,
      },
      isHeaderRequire: true,
      isLoader: showLoader,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (res) {
          result = MarketplaceSubscriptionPlan.listFromApiResponse(res);
        },
        onFailureCallback: (_) => result = const [],
      ),
    );

    return result;
  }

  Future<void> loadHistory() async {
    isLoadingHistory.value = true;
    try {
      final result = await fetchHistory(showLoader: false);
      history.assignAll(result);
    } finally {
      isLoadingHistory.value = false;
    }
  }

  Future<List<MarketplaceSubscriptionHistoryItem>> fetchHistory({
    bool showLoader = true,
  }) async {
    List<MarketplaceSubscriptionHistoryItem> result = const [];

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.marketplaceSubscriptionHistoryEndpoint,
      queryParameters: {
        '_': DateTime.now().millisecondsSinceEpoch,
      },
      isHeaderRequire: true,
      isLoader: showLoader,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (res) {
          result =
              MarketplaceSubscriptionHistoryItem.listFromApiResponse(res);
        },
        onFailureCallback: (_) => result = const [],
      ),
    );

    return result;
  }
}
