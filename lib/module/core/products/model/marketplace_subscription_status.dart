class MarketplaceSubscriptionStatus {
  final bool hasActiveSubscription;
  final int maxProducts;
  final int usedProducts;
  final int remainingProducts;
  final bool isMarketPlaceSubscription;
  final Map<String, dynamic>? activeSubscription;

  const MarketplaceSubscriptionStatus({
    required this.hasActiveSubscription,
    required this.maxProducts,
    required this.usedProducts,
    required this.remainingProducts,
    required this.isMarketPlaceSubscription,
    this.activeSubscription,
  });

  bool get canAddProduct =>
      hasActiveSubscription && remainingProducts > 0;

  bool get isProductLimitReached =>
      hasActiveSubscription && remainingProducts <= 0;

  String get planTitle {
    final plan = activeSubscription?['plan'];
    if (plan is Map) {
      final title = plan['title']?.toString().trim() ?? '';
      if (title.isNotEmpty) return title;
    }
    return '';
  }

  String get planDuration {
    final plan = activeSubscription?['plan'];
    if (plan is Map) {
      final duration = plan['duration']?.toString().trim() ?? '';
      if (duration.isNotEmpty) return duration;
    }
    return '';
  }

  /// Numeric plan id from active subscription (`planId` or nested `plan.id`).
  int? get activePlanId {
    if (!hasActiveSubscription || activeSubscription == null) return null;
    final direct = _toIntOrNull(activeSubscription!['planId']);
    if (direct != null && direct > 0) return direct;
    final plan = activeSubscription!['plan'];
    if (plan is Map) {
      return _toIntOrNull(plan['id']);
    }
    return null;
  }

  factory MarketplaceSubscriptionStatus.fromJson(Map<String, dynamic> json) {
    final active = json['activeSubscription'];
    return MarketplaceSubscriptionStatus(
      hasActiveSubscription: json['hasActiveSubscription'] == true,
      maxProducts: _toInt(json['maxProducts']),
      usedProducts: _toInt(json['usedProducts']),
      remainingProducts: _toInt(json['remainingProducts']),
      isMarketPlaceSubscription: json['isMarketPlaceSubscription'] == true,
      activeSubscription: active is Map
          ? Map<String, dynamic>.from(active)
          : null,
    );
  }

  static MarketplaceSubscriptionStatus? fromApiResponse(dynamic response) {
    final data = response is Map ? response['data'] : null;
    if (data is! Map) return null;
    return MarketplaceSubscriptionStatus.fromJson(
      Map<String, dynamic>.from(data),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int? _toIntOrNull(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}

class MarketplaceSubscriptionPlan {
  final int id;
  final String planId;
  final String title;
  final String duration;
  final String packageType;
  final String price;
  final String priceValue;
  final int maxProducts;
  final List<String> features;
  final bool popular;
  final bool isActive;

  const MarketplaceSubscriptionPlan({
    required this.id,
    required this.planId,
    required this.title,
    required this.duration,
    required this.packageType,
    required this.price,
    required this.priceValue,
    required this.maxProducts,
    required this.features,
    required this.popular,
    required this.isActive,
  });

  factory MarketplaceSubscriptionPlan.fromJson(Map<String, dynamic> json) {
    final featuresRaw = json['features'];
    final features = <String>[];
    if (featuresRaw is List) {
      for (final item in featuresRaw) {
        final text = item?.toString().trim() ?? '';
        if (text.isNotEmpty) features.add(text);
      }
    }

    return MarketplaceSubscriptionPlan(
      id: _toInt(json['id']),
      planId: json['planId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      packageType: json['packageType']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      priceValue: json['priceValue']?.toString() ?? '',
      maxProducts: _toInt(json['maxProducts']),
      features: features,
      popular: json['popular'] == true,
      isActive: json['isActive'] == true,
    );
  }

  static List<MarketplaceSubscriptionPlan> listFromApiResponse(
      dynamic response) {
    final data = response is Map ? response['data'] : null;
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((e) => MarketplaceSubscriptionPlan.fromJson(
              Map<String, dynamic>.from(e),
            ))
        .toList();
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class MarketplaceSubscriptionHistoryItem {
  final String id;
  final int planId;
  final String status;
  final String amount;
  final String paymentMethod;
  final String startDate;
  final String endDate;
  final String createdAt;
  final MarketplaceSubscriptionPlan? plan;

  const MarketplaceSubscriptionHistoryItem({
    required this.id,
    required this.planId,
    required this.status,
    required this.amount,
    required this.paymentMethod,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    this.plan,
  });

  String get planTitle => plan?.title ?? '';

  String get planDuration => plan?.duration ?? '';

  bool get isActive => status.toUpperCase() == 'ACTIVE';

  factory MarketplaceSubscriptionHistoryItem.fromJson(
      Map<String, dynamic> json) {
    final planRaw = json['plan'];
    return MarketplaceSubscriptionHistoryItem(
      id: json['id']?.toString() ?? '',
      planId: _toInt(json['planId']),
      status: json['status']?.toString() ?? '',
      amount: json['amount']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      startDate: json['startDate']?.toString() ?? '',
      endDate: json['endDate']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      plan: planRaw is Map
          ? MarketplaceSubscriptionPlan.fromJson(
              Map<String, dynamic>.from(planRaw),
            )
          : null,
    );
  }

  static List<MarketplaceSubscriptionHistoryItem> listFromApiResponse(
      dynamic response) {
    final data = response is Map ? response['data'] : null;
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((e) => MarketplaceSubscriptionHistoryItem.fromJson(
              Map<String, dynamic>.from(e),
            ))
        .toList();
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
