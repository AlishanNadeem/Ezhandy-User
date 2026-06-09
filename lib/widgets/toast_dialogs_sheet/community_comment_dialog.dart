import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/community/model/community_comment_model.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:ezhandy_user/widgets/button_widgets/reaction_button.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/text_fields/custom_text_field.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_community_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:intl/intl.dart';

class CommunityCommentsDialog extends StatefulWidget {
  final String postId;
  final int reactionTotal;

  const CommunityCommentsDialog({
    super.key,
    required this.postId,
    this.reactionTotal = 0,
  });

  @override
  State<CommunityCommentsDialog> createState() =>
      _CommunityCommentsDialogState();
}

class _CommunityCommentsDialogState extends State<CommunityCommentsDialog> {
  final TextEditingController _messageController = TextEditingController();

  List<CommunityComment> _comments = [];
  bool _loading = true;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _fetchComments(showListLoading: true);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String _formatDate(String iso) {
    if (iso.isEmpty) return '';
    try {
      return DateFormat('MMM d, y · h:mm a')
          .format(DateTime.parse(iso).toLocal());
    } catch (_) {
      return '';
    }
  }

  Future<void> _fetchComments({bool showListLoading = true}) async {
    if (!mounted) return;
    if (showListLoading) {
      setState(() => _loading = true);
    }

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.communityPostComments(widget.postId),
      isHeaderRequire: true,
    );

    if (!mounted) return;

    if (response == null) {
      setState(() {
        _comments = [];
        _loading = false;
      });
      return;
    }

    await DioClient().validateResponse(
      response: response,
      responseListener: _CommentsListener(
        onSuccessCallback: (res) {
          final raw = res?['data'];
          final list = raw is List
              ? raw
                  .map((e) => CommunityComment.fromJson(
                        Map<String, dynamic>.from(e as Map),
                      ))
                  .toList()
              : <CommunityComment>[];
          if (mounted) {
            setState(() {
              _comments = list;
              _loading = false;
            });
          }
        },
        onFailureCallback: (_) {
          if (mounted) {
            setState(() {
              _comments = [];
              _loading = false;
            });
          }
        },
      ),
    );

    if (mounted && _loading && showListLoading) {
      setState(() => _loading = false);
    }
  }

  Future<void> _sendComment() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);

    final response = await DioClient().postRequest(
      endPoint: NetworkStrings.communityPostComments(widget.postId),
      data: {'text': text},
      isHeaderRequire: true,
    );

    if (!mounted) return;

    if (response == null) {
      setState(() => _sending = false);
      return;
    }

    await DioClient().validateResponse(
      response: response,
      responseListener: _CommentsListener(
        onSuccessCallback: (_) {
          _messageController.clear();
          if (mounted) setState(() => _sending = false);
          _fetchComments(showListLoading: false);
        },
        onFailureCallback: (_) {
          if (mounted) setState(() => _sending = false);
        },
      ),
    );

    if (mounted && _sending) {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalCount =
        Constants.formatFacebookCount(widget.reactionTotal);

    return CustomCommunityDialog(
        title: "Comments",
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                        text: totalCount,
                        color: AppColors.greyLight,
                        fontSize: 10.sp),
                  ],
                ),
                FacebookReactionButton(
                  onTap: () {},
                ),
              ],
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _comments.isEmpty
                      ? Center(
                          child: CustomText(
                            text: 'No comments yet',
                            color: AppColors.greyLight,
                            fontSize: 12.sp,
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.only(
                              top: AppPadding.padding16,
                              bottom: AppPadding.padding12),
                          shrinkWrap: true,
                          itemCount: _comments.length,
                          itemBuilder: (context, index) {
                            return _commentTile(_comments[index]);
                          },
                          separatorBuilder: (context, index) {
                            return 10.verticalSpace;
                          },
                        ),
            ),
            10.verticalSpace,
            _messageTextField(),
          ],
        ));
  }

  Widget _commentTile(CommunityComment c) {
    final name = c.user?.fullName ?? '';
    final avatar = c.user?.profileImage;
    final day = _formatDate(c.createdAt);

    return CustomContainer(
      bgColor: AppColors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserImageWidget(
                image: avatar,
                size: 20.sp,
              ),
              5.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: name,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: day,
                      fontSize: 10.sp,
                      color: AppColors.greyLight,
                    ),
                    6.verticalSpace,
                    CustomText(text: c.text),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _messageTextField() {
    return CustomTextField(
      borderRadius: 5.r,
      borderColor: AppColors.greyBorder,
      fillColor: AppColors.transparent,
      hint: AppStrings.writeComment,
      hintColor: AppColors.greyLight,
      divider: false,
      label: false,
      sufixImage: _sending
          ? Padding(
              padding: EdgeInsets.all(8.r),
              child: SizedBox(
                width: 22.w,
                height: 22.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.orange,
                ),
              ),
            )
          : Image.asset(
              AssetPath.sendIcon,
              width: 30.w,
              height: 30.h,
              color: AppColors.orange,
            ),
      onclickSufix: _sending ? null : _sendComment,
      inputFormatters: [
        LengthLimitingTextInputFormatter(Constants.descriptionMaxLength)
      ],
      controller: _messageController,
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
}

class _CommentsListener extends ResponseListener {
  final void Function(dynamic response) onSuccessCallback;
  final void Function(dynamic response) onFailureCallback;

  _CommentsListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}
