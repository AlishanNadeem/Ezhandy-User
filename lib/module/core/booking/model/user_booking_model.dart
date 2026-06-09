import 'package:ezhandy_user/module/core/booking/model/booking_status_helper.dart';

class UserBooking {
  final int id;
  final int bookingId;
  final String providerId;
  final String providerName;
  final int serviceId;
  final String serviceName;
  final String bookingDate;
  final int status;
  final bool isPaid;
  final String? paymentId;
  final String amount;
  final bool isQuickService;
  final String createdAt;

  UserBooking({
    required this.id,
    required this.bookingId,
    required this.providerId,
    required this.providerName,
    required this.serviceId,
    required this.serviceName,
    required this.bookingDate,
    required this.status,
    required this.isPaid,
    this.paymentId,
    required this.amount,
    required this.isQuickService,
    required this.createdAt,
  });

  factory UserBooking.fromJson(Map<String, dynamic> json) {
    return UserBooking(
      id: _int(json['id']),
      bookingId: _int(json['bookingId'] ?? json['id']),
      providerId: json['providerId']?.toString() ?? '',
      providerName: json['providerName']?.toString() ?? '',
      serviceId: _int(json['serviceId']),
      serviceName: json['serviceName']?.toString() ?? '',
      bookingDate: json['bookingDate']?.toString() ?? '',
      status: _int(json['status']),
      isPaid: json['isPaid'] == true,
      paymentId: json['paymentId']?.toString(),
      amount: json['amount']?.toString() ?? '0',
      isQuickService: json['isQuickService'] == true,
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }

  String get statusLabel =>
      BookingStatusHelper.labelFromApi(status, isPaid: isPaid);

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
