import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/community/controller/community_posts_controller.dart';
import 'package:ezhandy_user/module/core/community/model/community_post_model.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class MyPostsController extends GetxController {
  static MyPostsController get i => Get.find();

  final RxList<CommunityPost> posts = <CommunityPost>[].obs;
  final RxBool postsLoading = false.obs;
  final RxBool deleteLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyPosts();
  }

  Future<void> fetchMyPosts() async {
    postsLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.communityPostsMineEndpoint,
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: _MyPostsListener(
          onSuccessCallback: (res) {
            final raw = res?['data'];
            if (raw is List) {
              posts.value = raw
                  .map((e) => CommunityPost.fromJson(
                        Map<String, dynamic>.from(e as Map),
                      ))
                  .toList();
            } else {
              posts.clear();
            }
          },
          onFailureCallback: (_) {
            posts.clear();
          },
        ),
      );
    } finally {
      postsLoading.value = false;
    }
  }

  Future<void> deletePost(
    String id, {
    required void Function() onSuccess,
  }) async {
    if (deleteLoading.value) return;
    deleteLoading.value = true;
    try {
      final response = await DioClient().deleteRequest(
        endPoint: NetworkStrings.communityPostById(id),
        isHeaderRequire: true,
        isLoader: false,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: _MyPostsListener(
          onSuccessCallback: (_) {
            posts.removeWhere((p) => p.id == id);
            if (Get.isRegistered<CommunityPostsController>()) {
              CommunityPostsController.i.fetchPosts();
            }
            onSuccess();
          },
          onFailureCallback: (_) {},
        ),
      );
    } finally {
      deleteLoading.value = false;
    }
  }
}

class _MyPostsListener extends ResponseListener {
  final void Function(dynamic response) onSuccessCallback;
  final void Function(dynamic response) onFailureCallback;

  _MyPostsListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}
