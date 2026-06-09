import 'package:get/get.dart';
import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';

class HomeController extends GetxController {
  static HomeController get i => Get.find();

    RxInt selectedTab = 0.obs;

  var servicesList = [].obs;
  RxBool isLoading = false.obs; 

  @override
  void onInit() {
    super.onInit();
    getServices();
  }

void getServices() async {
    isLoading.value = true; 
  final response = await DioClient().getRequest(
    endPoint: NetworkStrings.serviceTypesEndpoint,
    isHeaderRequire: true,
  );

  // ← THIS is the missing piece
  await DioClient().validateResponse(
    response: response,
    responseListener: _ServicesListener(onSuccessCallback: (response) {
      print("✅ SUCCESS: $response");
      servicesList.value = response?['data'] ?? [];
       isLoading.value = false; 
    }),
  );
   isLoading.value = false; 
}
}

// Concrete implementation of abstract ResponseListener
class _ServicesListener extends ResponseListener {
  final Function(dynamic response) onSuccessCallback;

  _ServicesListener({required this.onSuccessCallback});

  @override
  void onSuccess({var response}) {
    onSuccessCallback(response);
  }

  @override
  void onFailure({var response}) {
    print("API Failed: $response");
  }
}