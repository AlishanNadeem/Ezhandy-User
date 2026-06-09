class ActiveBookingSummary {
  final int id;
  final int status;
  final String statusLabel;
  final String bookingDate;
  final String totalAmount;
  final String bookingType;

  ActiveBookingSummary({
    required this.id,
    required this.status,
    required this.statusLabel,
    required this.bookingDate,
    required this.totalAmount,
    required this.bookingType,
  });

  factory ActiveBookingSummary.fromJson(Map<String, dynamic> json) {
    return ActiveBookingSummary(
      id: _int(json['id']),
      status: _int(json['status']),
      statusLabel: json['statusLabel']?.toString() ?? '',
      bookingDate: json['bookingDate']?.toString() ?? '',
      totalAmount: json['totalAmount']?.toString() ?? '0',
      bookingType: json['bookingType']?.toString() ?? '',
    );
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class ActiveBookingCheckResult {
  final bool hasActive;
  final ActiveBookingSummary? booking;
  final String statusLabel;

  ActiveBookingCheckResult({
    required this.hasActive,
    this.booking,
    required this.statusLabel,
  });

  factory ActiveBookingCheckResult.fromJson(Map<String, dynamic> json) {
    final bookingJson = json['booking'];
    ActiveBookingSummary? booking;
    if (bookingJson is Map<String, dynamic>) {
      booking = ActiveBookingSummary.fromJson(bookingJson);
    } else if (bookingJson is Map) {
      booking = ActiveBookingSummary.fromJson(
        Map<String, dynamic>.from(bookingJson),
      );
    }

    final statusLabel = json['statusLabel']?.toString() ??
        booking?.statusLabel ??
        '';

    return ActiveBookingCheckResult(
      hasActive: json['hasActive'] == true,
      booking: booking,
      statusLabel: statusLabel,
    );
  }
}
