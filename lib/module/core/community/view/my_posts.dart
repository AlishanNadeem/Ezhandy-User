import 'package:ezhandy_user/module/core/community/controller/my_posts_controller.dart';
import 'package:ezhandy_user/module/core/community/model/community_post_model.dart';
import 'package:ezhandy_user/module/core/community/routing_arguments/add_edit_post_routing_arguments.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/reaction_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  final MyPostsController _controller = Get.put(MyPostsController());

  @override
  void dispose() {
    Get.delete<MyPostsController>();
    super.dispose();
  }

  String _formatPostDate(String iso) {
    if (iso.isEmpty) return '';
    try {
      final dt = DateTime.parse(iso).toLocal();
      return DateFormat('MMM d, y').format(dt);
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        leading: AssetPath.backIcon,
        onclickLead: () {
          Get.back();
        },
        title: AppStrings.myPosts,
        appBarheight: 50,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppPadding.padding12),
            child: Column(
              children: [
                Expanded(
                  child: Obx(() => _buildBody(context)),
                ),
              ],
            )));
  }

  Widget _buildBody(BuildContext context) {
    if (_controller.postsLoading.value && _controller.posts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!_controller.postsLoading.value && _controller.posts.isEmpty) {
      return Center(
        child: CustomText(
          text: 'No posts yet',
          color: AppColors.greyLight,
          is_alignLeft: false,
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _controller.fetchMyPosts,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            top: AppPadding.padding20, bottom: AppPadding.padding25),
        shrinkWrap: true,
        itemCount: _controller.posts.length,
        itemBuilder: (context, index) {
          final post = _controller.posts[index];
          return postTile(context, post);
        },
        separatorBuilder: (context, index) {
          return 10.verticalSpace;
        },
      ),
    );
  }

  Widget postTile(BuildContext context, CommunityPost post) {
    final name = post.user?.fullName ?? '';
    final avatar = post.user?.profileImage;
    final day = _formatPostDate(post.createdAt);
    final likeCount =
        Constants.formatFacebookCount(post.reactionCounts.total);
    final commentLabel = post.commentCount == 1
        ? '1 Comment'
        : '${Constants.formatFacebookCount(post.commentCount)} Comments';

    return CustomContainer(
      child: Column(children: [
        Row(children: [
          UserImageWidget(
            image: avatar,
            size: 20.sp,
          ),
          5.horizontalSpace,
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(
                text: name, fontSize: 16.sp, fontWeight: FontWeight.bold),
            CustomText(
              text: day,
              fontSize: 12.sp,
            ),
          ]),
          Spacer(),
          GestureDetector(
              onTapDown: (TapDownDetails details) {
                _showPopupMenu(context, details.globalPosition, post);
              },
              child: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).colorScheme.primary,
              ))
        ]),
        5.verticalSpace,
        CustomText(text: post.description),
        if (post.image != null && post.image!.isNotEmpty) ...[
          10.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                post.image!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.greybg,
                  alignment: Alignment.center,
                  child: Icon(Icons.broken_image_outlined,
                      color: AppColors.greyLight),
                ),
              ),
            ),
          ),
        ],
        10.verticalSpace,
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  AppDialogs.showCommunityLikeDialog(context, postId: post.id);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30.w,
                      height: 20,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _staticReactionIcon(
                            icon: Icons.thumb_up,
                            color: Colors.blue,
                            left: 0,
                          ),
                          _staticReactionIcon(
                            icon: Icons.favorite,
                            color: Colors.red,
                            left: 8,
                          ),
                          _staticReactionIcon(
                            icon: Icons.emoji_emotions,
                            color: Colors.orange,
                            left: 15,
                          ),
                        ],
                      ),
                    ),
                    CustomText(
                        text: likeCount,
                        color: AppColors.greyLight,
                        fontSize: 10.sp),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  AppDialogs.showCommunityCommentsDialog(
                    context,
                    postId: post.id,
                    reactionTotal: post.reactionCounts.total,
                  );
                },
                child: CustomText(
                  text: commentLabel,
                  color: AppColors.greyLight,
                  fontSize: 10.sp,
                ),
              ),
            ]),
        Divider(),
        Row(
          children: [
            FacebookReactionButton(),
            const Spacer(),
            GestureDetector(
              onTap: () {
                AppDialogs.showCommunityCommentsDialog(
                    context,
                    postId: post.id,
                    reactionTotal: post.reactionCounts.total,
                  );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 15.sp,
                    color: AppColors.greyLight,
                  ),
                  5.horizontalSpace,
                  CustomText(
                    text: "Comment",
                    color: AppColors.greyLight,
                    fontSize: 10.sp,
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget _staticReactionIcon({
    required IconData icon,
    required Color color,
    required double left,
  }) {
    return Positioned(
      left: left,
      child: Center(
        child: Icon(
          icon,
          size: 12,
          color: color,
        ),
      ),
    );
  }

  void _showPopupMenu(
      BuildContext context, Offset position, CommunityPost post) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(position, position),
        Offset.zero & overlay.size,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      items: const [
        PopupMenuItem<String>(
          value: 'edit',
          child: Text('Edit'),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete'),
        )
      ],
    );

    switch (selected) {
      case 'edit':
        if (!context.mounted) return;
        AppNavigation.navigateTo(
          context,
          AppRoutes.createANewPostScreenRoute,
          arguments: AddEditPostRoutingArgument(
            type: AddEditType.edit.name,
            postId: post.id,
            description: post.description,
            imageUrl: post.image,
          ),
        );
        break;

      case 'delete':
        if (!context.mounted) return;
        _confirmDeletePost(context, post);
        break;
      default:
        break;
    }
  }

  void _closeDialog() {
    final ctx = Constants.navigatorKey.currentContext;
    if (ctx != null) {
      AppNavigation.navigateCloseDialog(ctx);
    }
  }

  void _confirmDeletePost(BuildContext context, CommunityPost post) {
    AppDialogs.showSuccessDialog(context,
        description: AppStrings.areYouSureWantToDeletePost,
        title: AppStrings.delete + "!",
        image: AssetPath.deletePopUpIcon,
        isDoneShow: false,
        btnTxt1: AppStrings.no,
        onTap1: _closeDialog,
        btnTxt2: AppStrings.yes,
        onTap2: () {
          _closeDialog();
          _controller.deletePost(post.id, onSuccess: () {
            final dialogContext = Constants.navigatorKey.currentContext;
            if (dialogContext == null || !dialogContext.mounted) return;
            AppDialogs.showSuccessDialog(
              dialogContext,
              description: "Post has been deleted successfully.",
              title: AppStrings.congratulation,
              isDoneShow: true,
              btnTxt1: AppStrings.ok,
              onTap1: _closeDialog,
            );
          });
        });
  }
}
