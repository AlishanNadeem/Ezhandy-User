import 'package:ezhandy_user/module/core/community/model/community_post_model.dart';

class CommunityComment {
  final String id;
  final String postId;
  final String userId;
  final String text;
  final String createdAt;
  final CommunityPostUser? user;

  CommunityComment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.text,
    required this.createdAt,
    this.user,
  });

  factory CommunityComment.fromJson(Map<String, dynamic> json) {
    return CommunityComment(
      id: json['id']?.toString() ?? '',
      postId: json['postId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      user: json['user'] is Map<String, dynamic>
          ? CommunityPostUser.fromJson(
              Map<String, dynamic>.from(json['user'] as Map),
            )
          : null,
    );
  }
}
