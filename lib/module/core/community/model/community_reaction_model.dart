import 'package:ezhandy_user/module/core/community/model/community_post_model.dart';
import 'package:ezhandy_user/module/core/community/model/community_reaction_type.dart';

class ReactionCountsData {
  final int all;
  final int thumb;
  final int heart;
  final int smile;

  ReactionCountsData({
    required this.all,
    required this.thumb,
    required this.heart,
    required this.smile,
  });

  factory ReactionCountsData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ReactionCountsData(all: 0, thumb: 0, heart: 0, smile: 0);
    }
    int n(dynamic v) => v is int ? v : int.tryParse(v?.toString() ?? '') ?? 0;
    return ReactionCountsData(
      all: n(json['all']),
      thumb: n(json['thumb']),
      heart: n(json['heart']),
      smile: n(json['smile']),
    );
  }
}

class PostReaction {
  final String id;
  final String userId;
  final String reactionType;
  final String createdAt;
  final CommunityPostUser? user;

  PostReaction({
    required this.id,
    required this.userId,
    required this.reactionType,
    required this.createdAt,
    this.user,
  });

  /// Parses one reaction row; returns `null` if [reactionType] is not thumb/heart/smile.
  static PostReaction? tryParse(Map<String, dynamic> json) {
    final type =
        CommunityReactionType.normalize(json['reactionType']?.toString());
    if (type == null) return null;
    return PostReaction(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      reactionType: type,
      createdAt: json['createdAt']?.toString() ?? '',
      user: json['user'] is Map<String, dynamic>
          ? CommunityPostUser.fromJson(
              Map<String, dynamic>.from(json['user'] as Map),
            )
          : null,
    );
  }
}

class CommunityReactionsResult {
  final ReactionCountsData counts;
  final List<PostReaction> reactions;

  CommunityReactionsResult({
    required this.counts,
    required this.reactions,
  });

  factory CommunityReactionsResult.fromApiData(Map<String, dynamic>? data) {
    if (data == null) {
      return CommunityReactionsResult(
        counts: ReactionCountsData.fromJson(null),
        reactions: [],
      );
    }
    final countsMap = data['counts'] is Map<String, dynamic>
        ? data['counts'] as Map<String, dynamic>
        : null;
    final rawList = data['reactions'];
    final reactions = <PostReaction>[];
    if (rawList is List) {
      for (final e in rawList) {
        if (e is Map) {
          final parsed = PostReaction.tryParse(Map<String, dynamic>.from(e));
          if (parsed != null) reactions.add(parsed);
        }
      }
    }
    return CommunityReactionsResult(
      counts: ReactionCountsData.fromJson(countsMap),
      reactions: reactions,
    );
  }
}
