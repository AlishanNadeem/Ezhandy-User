import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/community/model/community_reaction_model.dart';
import 'package:ezhandy_user/module/core/community/model/community_reaction_type.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/constant.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:ezhandy_user/widgets/profile_widget/user_image_widget.dart';
import 'package:ezhandy_user/widgets/toast_dialogs_sheet/custom_community_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';

class CommunityLikeDialog extends StatefulWidget {
  final String postId;

  const CommunityLikeDialog({
    super.key,
    required this.postId,
  });

  @override
  State<CommunityLikeDialog> createState() => _CommunityLikeDialogState();
}

class _CommunityLikeDialogState extends State<CommunityLikeDialog> {
  CommunityReactionsResult? _result;
  bool _loading = true;
  /// `null` = all reactions; otherwise [CommunityReactionType.thumb], [heart], or [smile].
  String? _filterType;

  @override
  void initState() {
    super.initState();
    _fetchReactions();
  }

  Future<void> _fetchReactions() async {
    if (!mounted) return;
    setState(() => _loading = true);

    final response = await DioClient().getRequest(
      endPoint: NetworkStrings.communityPostReactions(widget.postId),
      isHeaderRequire: true,
    );

    if (!mounted) return;

    if (response == null) {
      setState(() {
        _result = null;
        _loading = false;
      });
      return;
    }

    await DioClient().validateResponse(
      response: response,
      responseListener: _ReactionsListener(
        onSuccessCallback: (res) {
          final data = res is Map<String, dynamic> ? res['data'] : null;
          final map = data is Map<String, dynamic> ? data : null;
          if (mounted) {
            setState(() {
              _result = CommunityReactionsResult.fromApiData(map);
              _loading = false;
            });
          }
        },
        onFailureCallback: (_) {
          if (mounted) {
            setState(() {
              _result = null;
              _loading = false;
            });
          }
        },
      ),
    );

    if (mounted && _loading) {
      setState(() => _loading = false);
    }
  }

  List<PostReaction> get _visibleReactions {
    final r = _result;
    if (r == null) return [];
    if (_filterType == null) return r.reactions;
    return r.reactions.where((e) => e.reactionType == _filterType).toList();
  }

  void _selectFilter(String? type) {
    setState(() => _filterType = type);
  }

  @override
  Widget build(BuildContext context) {
    final counts = _result?.counts;

    return CustomCommunityDialog(
        title: "People Who Reacted",
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _filterChip(
                      label:
                          'All ${Constants.formatFacebookCount(counts?.all ?? 0)}',
                      icon: null,
                      selected: _filterType == null,
                      onTap: () => _selectFilter(null),
                    ),
                    _verticalDivider(),
                    _filterChip(
                      label: Constants.formatFacebookCount(counts?.thumb ?? 0),
                      icon: CommunityReactionType.icon(
                          CommunityReactionType.thumb),
                      iconColor:
                          CommunityReactionType.color(CommunityReactionType.thumb),
                      selected: _filterType == CommunityReactionType.thumb,
                      onTap: () => _selectFilter(CommunityReactionType.thumb),
                    ),
                    _verticalDivider(),
                    _filterChip(
                      label: Constants.formatFacebookCount(counts?.heart ?? 0),
                      icon: CommunityReactionType.icon(
                          CommunityReactionType.heart),
                      iconColor:
                          CommunityReactionType.color(CommunityReactionType.heart),
                      selected: _filterType == CommunityReactionType.heart,
                      onTap: () => _selectFilter(CommunityReactionType.heart),
                    ),
                    _verticalDivider(),
                    _filterChip(
                      label: Constants.formatFacebookCount(counts?.smile ?? 0),
                      icon: CommunityReactionType.icon(
                          CommunityReactionType.smile),
                      iconColor:
                          CommunityReactionType.color(CommunityReactionType.smile),
                      selected: _filterType == CommunityReactionType.smile,
                      onTap: () => _selectFilter(CommunityReactionType.smile),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _visibleReactions.isEmpty
                      ? Center(
                          child: CustomText(
                            text: 'No reactions',
                            color: AppColors.greyLight,
                            fontSize: 12.sp,
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.only(
                              top: AppPadding.padding20,
                              bottom: AppPadding.padding25),
                          shrinkWrap: true,
                          itemCount: _visibleReactions.length,
                          itemBuilder: (context, index) {
                            final item = _visibleReactions[index];
                            return _userRow(item);
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        ),
            ),
          ],
        ));
  }

  Widget _userRow(PostReaction item) {
    final name = item.user?.fullName ?? '';
    final avatar = item.user?.profileImage;
    final icon = CommunityReactionType.icon(item.reactionType);
    final iconColor = CommunityReactionType.color(item.reactionType);

    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            UserImageWidget(
              image: avatar,
              size: 20.sp,
            ),
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
        10.horizontalSpace,
        Expanded(
          child: CustomText(
            text: name.isEmpty ? 'User' : name,
          ),
        ),
      ],
    );
  }

  Widget _filterChip({
    required String label,
    IconData? icon,
    Color? iconColor,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: selected ? AppColors.orange.withValues(alpha: 0.12) : null,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? AppColors.orange : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: iconColor ?? Colors.grey,
                  size: 16,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: selected ? AppColors.orange : Colors.grey,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 18,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}

class _ReactionsListener extends ResponseListener {
  final void Function(dynamic response) onSuccessCallback;
  final void Function(dynamic response) onFailureCallback;

  _ReactionsListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}
