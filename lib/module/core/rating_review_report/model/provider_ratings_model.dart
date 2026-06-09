class RatingUser {
  final String id;
  final String fullName;

  RatingUser({required this.id, required this.fullName});

  factory RatingUser.fromJson(Map<String, dynamic> json) {
    return RatingUser(
      id: json['id']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
    );
  }
}

class ProviderRatingItem {
  final String id;
  final int rating;
  final String review;
  final String createdAt;
  final RatingUser? ratingUser;

  ProviderRatingItem({
    required this.id,
    required this.rating,
    required this.review,
    required this.createdAt,
    this.ratingUser,
  });

  factory ProviderRatingItem.fromJson(Map<String, dynamic> json) {
    final userJson = json['ratingUser'];
    RatingUser? user;
    if (userJson is Map<String, dynamic>) {
      user = RatingUser.fromJson(userJson);
    } else if (userJson is Map) {
      user = RatingUser.fromJson(Map<String, dynamic>.from(userJson));
    }

    return ProviderRatingItem(
      id: json['id']?.toString() ?? '',
      rating: _int(json['rating']),
      review: json['review']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      ratingUser: user,
    );
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class ProviderRatingsData {
  final String providerId;
  final String providerName;
  final String currentRating;
  final int totalRatings;
  final List<ProviderRatingItem> ratings;

  ProviderRatingsData({
    required this.providerId,
    required this.providerName,
    required this.currentRating,
    required this.totalRatings,
    required this.ratings,
  });

  factory ProviderRatingsData.fromJson(Map<String, dynamic> json) {
    final rawList = json['ratings'];
    final list = rawList is List
        ? rawList
            .map(
              (e) => ProviderRatingItem.fromJson(
                Map<String, dynamic>.from(e as Map),
              ),
            )
            .toList()
        : <ProviderRatingItem>[];

    return ProviderRatingsData(
      providerId: json['providerId']?.toString() ?? '',
      providerName: json['providerName']?.toString() ?? '',
      currentRating: json['currentRating']?.toString() ?? '0',
      totalRatings: _int(json['totalRatings']),
      ratings: list,
    );
  }

  double get currentRatingValue =>
      double.tryParse(currentRating) ?? 0;

  List<Map<String, dynamic>> get starBreakdown {
    final counts = <int, int>{5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final item in ratings) {
      if (counts.containsKey(item.rating)) {
        counts[item.rating] = counts[item.rating]! + 1;
      }
    }

    final total = totalRatings > 0 ? totalRatings : ratings.length;
    return [5, 4, 3, 2, 1]
        .map(
          (star) => {
            'num': star.toString(),
            'count': counts[star]!.toString(),
            'percent': total > 0 ? counts[star]! / total : 0.0,
          },
        )
        .toList();
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
