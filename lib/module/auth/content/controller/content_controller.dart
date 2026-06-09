import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/auth/content/model/content_page_model.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  ContentController({required this.slug});

  final String slug;

  final RxBool isLoading = false.obs;
  final Rxn<ContentPage> page = Rxn<ContentPage>();

  @override
  void onInit() {
    super.onInit();
    fetchPage();
  }

  Future<void> fetchPage() async {
    isLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.pageBySlug(slug),
        isHeaderRequire: false,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (res) {
            final raw = res is Map ? res['data'] : null;
            if (raw is Map) {
              page.value = ContentPage.fromJson(
                Map<String, dynamic>.from(raw),
              );
            } else {
              page.value = null;
            }
          },
          onFailureCallback: (_) => page.value = null,
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
