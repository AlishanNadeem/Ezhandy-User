class CommunityPostUser {
  final String id;
  final String fullName;
  final String? profileImage;

  CommunityPostUser({
    required this.id,
    required this.fullName,
    this.profileImage,
  });

  factory CommunityPostUser.fromJson(Map<String, dynamic> json) {
    return CommunityPostUser(
      id: json['id']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      profileImage: json['profileImage']?.toString(),
    );
  }
}

class ReactionCounts {
  final int thumb;
  final int heart;
  final int smile;
  final int total;

  ReactionCounts({
    required this.thumb,
    required this.heart,
    required this.smile,
    required this.total,
  });

  factory ReactionCounts.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ReactionCounts(thumb: 0, heart: 0, smile: 0, total: 0);
    }
    int n(dynamic v) => v is int ? v : int.tryParse(v?.toString() ?? '') ?? 0;
    return ReactionCounts(
      thumb: n(json['thumb']),
      heart: n(json['heart']),
      smile: n(json['smile']),
      total: n(json['total']),
    );
  }
}

class CommunityPost {
  final String id;
  final String userId;
  final String description;
  final String? image;
  final String createdAt;
  final String updatedAt;
  final bool isOwner;
  final CommunityPostUser? user;
  final ReactionCounts reactionCounts;
  final String? myReaction;
  final int commentCount;

  CommunityPost({
    required this.id,
    required this.userId,
    required this.description,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.isOwner,
    this.user,
    required this.reactionCounts,
    this.myReaction,
    required this.commentCount,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    int n(dynamic v) => v is int ? v : int.tryParse(v?.toString() ?? '') ?? 0;
    return CommunityPost(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString(),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      isOwner: json['isOwner'] == true,
      user: json['user'] is Map<String, dynamic>
          ? CommunityPostUser.fromJson(
              Map<String, dynamic>.from(json['user'] as Map),
            )
          : null,
      reactionCounts:
          ReactionCounts.fromJson(json['reactionCounts'] as Map<String, dynamic>?),
      myReaction: json['myReaction']?.toString(),
      commentCount: n(json['commentCount']),
    );
  }
}
