import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
import 'package:ezhandy_user/module/core/community/data/repository/ask_pro_checkout_repository.dart';
import 'package:ezhandy_user/module/core/community/controller/community_posts_controller.dart';
import 'package:ezhandy_user/module/core/community/model/community_post_model.dart';
import 'package:ezhandy_user/module/core/community/routing_arguments/add_edit_post_routing_arguments.dart';
import 'package:ezhandy_user/module/core/main_menu/main_menu_user.dart';
import 'package:ezhandy_user/utils/app_dialogs.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/enums.dart';
import 'package:ezhandy_user/utils/routes/app_navigation.dart';
import 'package:ezhandy_user/utils/routes/app_route.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/button_widgets/reaction_button.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final CommunityPostsController _postsController =
      Get.put(CommunityPostsController());

  @override
  void dispose() {
    Get.delete<CommunityPostsController>();
    super.dispose();
  }

  String _formatPostDate(String iso) {
    if (iso.isEmpty) return '';
    try {
      final dt = DateTime.parse(iso).toLocal();
      return DateFormat('MMM d, y · h:mm a').format(dt);
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          10.verticalSpace,
          appbarWidget(),
          20.verticalSpace,

          Row(
            children: [
              Expanded(
                  child: CustomButton(
                text: AppStrings.AskAPro,
                onclick: () {
                  AppDialogs.showSuccessDialog(context,
                      description:
                          "Get expert help instantly. Make a payment to ask a Pro.",
                      title: "\$4.99/ 5 text messages",
                      image: AssetPath.proUserIcon,
                      isDoneShow: false,
                      btnTxt1: AppStrings.continuee,
                      onTap1: () {
                        AppNavigation.navigateCloseDialog(context);
                        AskProCheckoutRepository().startCheckout(context);
                      },
                      btnTxt2: AppStrings.cancel,
                      onTap2: () {
                        AppNavigation.navigatorPop(context);
                      });
                },
              )),
              10.horizontalSpace,
              Expanded(
                  child: CustomButton(
                onclick: () {
                  AppNavigation.navigateTo(
                      context, AppRoutes.myPostsScreenRoute);
                },
                text: AppStrings.myPosts,
                color: AppColors.black,
              )),
            ],
          ),
          20.verticalSpace,
          CustomContainer(
              onTap: () {
                AppNavigation.navigateTo(
                    context, AppRoutes.createANewPostScreenRoute,
                    arguments:
                        AddEditPostRoutingArgument(type: AddEditType.add.name));
              },
              child: Column(
                children: [
                  CustomText(
                      text: AppStrings.createANewPost,
                      fontWeight: FontWeight.bold),
                  10.verticalSpace,
                  Row(
                    children: [
                      UserImageWidget(size: 20, image: AuthController.i.appUser.value.data?.userModel?.profileImage ?? null),
                      10.horizontalSpace,
                      Flexible(
                        child: CustomContainer(
                            bgColor: AppColors.greybg,
                            borderColor: AppColors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: AppStrings.saySomeThing + "...",
                                  color: AppColors.greyLight,
                                ),
                                Icon(Icons.image_outlined)
                              ],
                            )),
                      )
                    ],
                  )
                ],
              )),
          20.verticalSpace,
          searchTextField(),
          Expanded(child: Obx(() => _buildFeed())),
        ],
      ),
    );
  }

  Widget _buildFeed() {
    if (_postsController.postsLoading.value &&
        _postsController.posts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!_postsController.postsLoading.value &&
        _postsController.posts.isEmpty) {
      return Center(
        child: CustomText(
          text: 'No posts yet',
          color: AppColors.greyLight,
          is_alignLeft: false,
        ),
      );
    }

    final posts = _postsController.filteredPosts;
    if (posts.isEmpty) {
      return Center(
        child: CustomText(
          text: 'No posts found',
          color: AppColors.greyLight,
          is_alignLeft: false,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _postsController.fetchPosts,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            top: AppPadding.padding20, bottom: AppPadding.padding25),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return postTile(post);
        },
        separatorBuilder: (context, index) {
          return 10.verticalSpace;
        },
      ),
    );
  }

  Widget searchTextField() {
    return CustomTextField(
      label: false,
      prefxicon: AssetPath.searchIcon,
      hint: AppStrings.searchAnything,
      inputFormatters: [LengthLimitingTextInputFormatter(35)],
      onchange: _postsController.updateSearch,
    );
  }

  Row appbarWidget() {
    return Row(
      children: [
        GestureDetector(
          onTap: (!AuthController.i.isLoginSignUp.value)
              ? () {
                  signinSignUpPopup();
                }
              : () {
                  globalkey.currentState!.openDrawer();
                },
          child: Image.asset(
            AssetPath.menuIcon,
            alignment: Alignment.centerLeft,
            scale: 4.sp,
            color: AppColors.black,
          ),
        ),
        10.horizontalSpace,
        CustomText(
          text: AppStrings.community,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        Spacer(),
        notificationWidget(context)
      ],
    );
  }

  GestureDetector notificationWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigation.navigateTo(context, AppRoutes.notificationScreenRoute);
      },
      child: Image.asset(AssetPath.bellIcon, width: 20.w, height: 20.h),
    );
  }

  Widget postTile(CommunityPost post) {
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

  void signinSignUpPopup() {
    AppDialogs.showSuccessDialog(
      context,
      barrierDismissible: true,
      description: AppStrings.inOrderToAccessThis,
      image: AssetPath.tumbIcon,
      isDoneShow: false,
      btnTxt1: AppStrings.logIn.toUpperCase(),
      onTap1: () {
        AppNavigation.navigateToRemovingAll(
            context, AppRoutes.loginScreenRoute);
      },
      btnTxt2: AppStrings.signUp.toUpperCase(),
      onTap2: () {
        AppNavigation.navigateToRemovingAll(
            context, AppRoutes.loginScreenRoute);
        AppNavigation.navigateTo(context, AppRoutes.signupScreenRoute);
      },
    );
  }
}
