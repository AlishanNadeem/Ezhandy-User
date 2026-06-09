import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class FavouritesServicesController extends GetxController {
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final Rxn<String> removingServiceId = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    fetchFavourites();
  }

  Future<void> fetchFavourites() async {
    isLoading.value = true;

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.favouriteServicesListEndpoint,
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

  /// Same id as POST/DELETE `favourites/services/{id}` (provider-service row id).
  static String serviceApiIdFromRow(Map<String, dynamic> row) {
    final service = row['service'];
    if (service is Map) {
      final m = Map<String, dynamic>.from(service);
      final id = m['id']?.toString().trim() ?? '';
      if (id.isNotEmpty) return id;
    }
    return row['serviceId']?.toString().trim() ?? '';
  }

  Future<void> removeServiceFromFavourites(String serviceApiId) async {
    if (serviceApiId.isEmpty) return;
    if (removingServiceId.value != null) return;

    removingServiceId.value = serviceApiId;
    try {
      final response = await DioClient().deleteRequest(
        endPoint: NetworkStrings.favouriteService(serviceApiId),
        isHeaderRequire: true,
        isLoader: false,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: CallbackResponseListener(
          onSuccessCallback: (_) {
            items.removeWhere(
              (row) => serviceApiIdFromRow(row) == serviceApiId,
            );
          },
          onFailureCallback: (_) {},
        ),
      );
    } finally {
      removingServiceId.value = null;
    }
  }
}
