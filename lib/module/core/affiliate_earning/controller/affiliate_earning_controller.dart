import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class AffiliateEarningController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rxn<Map<String, dynamic>> referralData = Rxn<Map<String, dynamic>>();

  List<Map<String, dynamic>> get referrals {
    final raw = referralData.value?['referrals'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<void> fetchMyReferrals() async {
    isLoading.value = true;
    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.myReferralsEndpoint,
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: _ReferralsListener(
        onSuccessCallback: (res) {
          final data = res?['data'];
          if (data is Map<String, dynamic>) {
            referralData.value = data;
          } else if (data is Map) {
            referralData.value = Map<String, dynamic>.from(data);
          } else {
            referralData.value = null;
          }
          isLoading.value = false;
        },
        onFailureCallback: (_) {
          referralData.value = null;
          isLoading.value = false;
        },
      ),
    );
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyReferrals();
  }
}

class _ReferralsListener extends ResponseListener {
  final void Function(dynamic response) onSuccessCallback;
  final void Function(dynamic response) onFailureCallback;

  _ReferralsListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}
