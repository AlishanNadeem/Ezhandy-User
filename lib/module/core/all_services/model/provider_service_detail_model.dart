class ProviderServiceDetailModel {
  final String title;
  final String description;
  final String visitCharges;
  final String hourlyRate;
  final String imageUrl;
  final String providerName;
  final String providerImage;
  final String serviceTypeName;

  ProviderServiceDetailModel({
    required this.title,
    required this.description,
    required this.visitCharges,
    required this.hourlyRate,
    required this.imageUrl,
    required this.providerName,
    required this.providerImage,
    required this.serviceTypeName,
  });

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  factory ProviderServiceDetailModel.fromJson(Map<String, dynamic> json) {
    final user = _asMap(json['user']);
    final serviceType = _asMap(json['serviceType']);

    return ProviderServiceDetailModel(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      visitCharges: json['visitCharges']?.toString() ?? '0',
      hourlyRate: json['hourlyRate']?.toString() ?? '0',
      imageUrl: json['imageUrl']?.toString() ?? '',
      providerName: user?['fullName']?.toString() ?? '',
      providerImage: user?['profileImage']?.toString() ?? '',
      serviceTypeName: serviceType?['name']?.toString() ?? '',
    );
  }
}
