import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class PastWorkController extends GetxController {
  PastWorkController({
    required this.providerId,
    required this.serviceId,
  });

  final String providerId;
  final String serviceId;

  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPastWork();
  }

  Future<void> fetchPastWork() async {
    if (providerId.isEmpty || serviceId.isEmpty) {
      items.clear();
      return;
    }

    isLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.pastWorkByProviderService(
          providerId: providerId,
          serviceId: serviceId,
        ),
        isHeaderRequire: true,
        isLoader: false,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            final raw = res is Map ? res['data'] : null;
            if (raw is List) {
              items.assignAll(
                raw
                    .whereType<Map>()
                    .map((e) => Map<String, dynamic>.from(e))
                    .toList(),
              );
            } else {
              items.clear();
            }
          },
          onFailureCallback: (_) => items.clear(),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
