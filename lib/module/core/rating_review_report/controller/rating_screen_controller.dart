import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/rating_review_report/model/provider_ratings_model.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class RatingScreenController extends GetxController {
  RatingScreenController({required this.providerId});

  final String providerId;

  final RxBool isLoading = false.obs;
  final Rxn<ProviderRatingsData> ratingsData = Rxn<ProviderRatingsData>();

  @override
  void onInit() {
    super.onInit();
    fetchProviderRatings();
  }

  Future<void> fetchProviderRatings() async {
    final id = providerId.trim();
    if (id.isEmpty) return;

    isLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.providerRatings(id),
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (r) {
          final data = r is Map ? r['data'] : null;
          if (data is Map<String, dynamic>) {
            ratingsData.value = ProviderRatingsData.fromJson(data);
          } else if (data is Map) {
            ratingsData.value = ProviderRatingsData.fromJson(
              Map<String, dynamic>.from(data),
            );
          } else {
            ratingsData.value = null;
          }
        },
        onFailureCallback: (_) {
          ratingsData.value = null;
        },
      ),
    );

    isLoading.value = false;
  }
}
