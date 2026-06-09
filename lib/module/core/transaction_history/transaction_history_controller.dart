import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class TransactionHistoryController extends GetxController {
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    isLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.userPaymentsEndpoint,
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
}
