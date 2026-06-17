class AskProPricing {
  final bool alreadyActive;
  final bool isAskPro;
  final double amount;
  final int amountCents;
  final String amountLabel;
  final String description;
  final List<String> features;
  final bool isFirstTime;
  final bool isRepeat;

  const AskProPricing({
    required this.alreadyActive,
    required this.isAskPro,
    required this.amount,
    required this.amountCents,
    required this.amountLabel,
    required this.description,
    required this.features,
    required this.isFirstTime,
    required this.isRepeat,
  });

  factory AskProPricing.fromJson(Map<String, dynamic> json) {
    final featuresRaw = json['features'];
    final features = <String>[];
    if (featuresRaw is List) {
      for (final item in featuresRaw) {
        final text = item?.toString().trim() ?? '';
        if (text.isNotEmpty) features.add(text);
      }
    }

    return AskProPricing(
      alreadyActive: json['alreadyActive'] == true,
      isAskPro: json['isAskPro'] == true,
      amount: _toDouble(json['amount']),
      amountCents: _toInt(json['amountCents']),
      amountLabel: json['amountLabel']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      features: features,
      isFirstTime: json['isFirstTime'] == true,
      isRepeat: json['isRepeat'] == true,
    );
  }

  static AskProPricing? fromApiResponse(dynamic response) {
    final outer = response is Map ? response['data'] : null;
    if (outer is! Map) return null;

    final inner = outer['data'];
    if (inner is! Map) return null;

    return AskProPricing.fromJson(Map<String, dynamic>.from(inner));
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
