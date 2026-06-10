import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/community/model/community_post_model.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/local_search_helper.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class CommunityPostsController extends GetxController {
  static CommunityPostsController get i => Get.find();

  final RxList<CommunityPost> posts = <CommunityPost>[].obs;
  final RxBool postsLoading = false.obs;
  final RxString searchQuery = ''.obs;

  List<CommunityPost> get filteredPosts => filterListByTitle<CommunityPost>(
        items: posts,
        query: searchQuery.value,
        titleOf: (post) => post.user?.fullName ?? '',
      );

  void updateSearch(String value) => searchQuery.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    postsLoading.value = true;
    try {
      final response = await DioClient().getRequest(
        endPoint: NetworkStrings.communityPostsEndpoint,
        isHeaderRequire: true,
      );

      await DioClient().validateResponse(
        response: response,
        responseListener: _CommunityPostsListener(
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
}

class _CommunityPostsListener extends ResponseListener {
  final void Function(dynamic response) onSuccessCallback;
  final void Function(dynamic response) onFailureCallback;

  _CommunityPostsListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}
