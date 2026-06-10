import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/local_search_helper.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class ListOfServicesController extends GetxController {
  static ListOfServicesController get i => Get.find();

  final bool isQuick;

  ListOfServicesController({required this.isQuick});

  RxList servicesList = [].obs;
  RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  List<dynamic> get filteredServicesList => filterMapsByTitleKey(
        items: servicesList,
        query: searchQuery.value,
        titleKey: 'name',
      );

  void updateSearch(String value) => searchQuery.value = value;

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
      isLoader: false,
      queryParameters: {'isQuick': isQuick},
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: _Listener(
        onSuccessCallback: (response) {
          print("✅ Services: $response");
          servicesList.value = response?['data'] ?? [];
          isLoading.value = false;
        },
        onFailureCallback: (response) {
          print("❌ Services Failed: $response");
          isLoading.value = false;
        },
      ),
    );
    isLoading.value = false;
  }
}

class _Listener extends ResponseListener {
  final Function(dynamic) onSuccessCallback;
  final Function(dynamic) onFailureCallback;

  _Listener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}