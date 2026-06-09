/// Backend-aligned enums and API types (mirrors server TypeScript definitions).

class ApiResponse<T> {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final T? data;

  const ApiResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T? Function(dynamic)? dataParser,
  ) {
    return ApiResponse(
      isSuccess: json['isSuccess'] == true,
      statusCode: _int(json['statusCode']),
      message: json['message']?.toString() ?? '',
      data: dataParser != null ? dataParser(json['data']) : json['data'] as T?,
    );
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

enum ResponseCode {
  success(200),
  created(201),
  accepted(202),
  noContent(204),
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  conflict(409),
  unprocessable(422),
  serverError(500),
  otpExpire(423),
  subscriptionRequired(498),
  emailVerificationRequired(499);

  const ResponseCode(this.code);
  final int code;

  static ResponseCode? fromCode(int code) {
    for (final v in ResponseCode.values) {
      if (v.code == code) return v;
    }
    return null;
  }
}

enum Gender {
  male('male'),
  female('female'),
  other('other');

  const Gender(this.value);
  final String value;

  static Gender? fromValue(String? raw) {
    final s = raw?.trim().toLowerCase();
    if (s == null || s.isEmpty) return null;
    for (final g in Gender.values) {
      if (g.value == s) return g;
    }
    return null;
  }
}

class LanguageOption {
  final String value;
  final String label;

  const LanguageOption({required this.value, required this.label});
}

const languageOptions = [
  LanguageOption(value: '1', label: 'English'),
  LanguageOption(value: '2', label: 'Spanish'),
  LanguageOption(value: '3', label: 'French'),
];

enum Language {
  english('1', 'English'),
  spanish('2', 'Spanish'),
  french('3', 'French');

  const Language(this.value, this.label);
  final String value;
  final String label;

  String get displayLabel => label;

  static Language? fromValue(String? raw) {
    final s = raw?.trim();
    if (s == null || s.isEmpty) return null;
    for (final l in Language.values) {
      if (l.value == s) return l;
    }
    final lower = s.toLowerCase();
    for (final l in Language.values) {
      if (l.label.toLowerCase() == lower) return l;
    }
    return null;
  }

  static Language? fromId(int? id) => fromValue(id?.toString());

  static String? labelForValue(String? raw) => fromValue(raw)?.label;
}

enum RoleId {
  user(1),
  provider(2),
  admin(3);

  const RoleId(this.id);
  final int id;

  static RoleId? fromId(int? id) {
    if (id == null) return null;
    for (final r in RoleId.values) {
      if (r.id == id) return r;
    }
    return null;
  }
}

/// Matches [BookingStatusHelper] / API booking status codes.
enum BookingStatusEnum {
  pending(1),
  rejected(2),
  assigned(3),
  inRoute(4),
  started(5),
  completed(6),
  userVerifiedIsDone(7),
  cancelled(8);

  const BookingStatusEnum(this.code);
  final int code;

  static BookingStatusEnum? fromCode(int? code) {
    if (code == null) return null;
    for (final s in BookingStatusEnum.values) {
      if (s.code == code) return s;
    }
    return null;
  }
}

/// Same values as [BookingStatusEnum] on the backend.
enum JobStatus {
  pending(1),
  rejected(2),
  assigned(3),
  inRoute(4),
  started(5),
  completed(6),
  userVerifiedIsDone(7),
  cancelled(8);

  const JobStatus(this.code);
  final int code;

  static JobStatus? fromCode(int? code) {
    if (code == null) return null;
    for (final s in JobStatus.values) {
      if (s.code == code) return s;
    }
    return null;
  }
}

enum CancelReason {
  providerNotAvailable('Provider not available'),
  changedMyMind('Changed my mind'),
  wrongService('Wrong service selected'),
  pricingIssue('Pricing issue'),
  emergency('Personal emergency'),
  providerLate('Provider was too late'),
  other('Other');

  const CancelReason(this.label);
  final String label;

  static CancelReason? fromLabel(String? raw) {
    final s = raw?.trim();
    if (s == null || s.isEmpty) return null;
    for (final r in CancelReason.values) {
      if (r.label == s) return r;
    }
    return null;
  }
}

enum RefundStatus {
  none('none'),
  requested('requested'),
  approved('approved'),
  rejected('rejected');

  const RefundStatus(this.value);
  final String value;

  static RefundStatus? fromValue(String? raw) {
    final s = raw?.trim().toLowerCase();
    if (s == null || s.isEmpty) return null;
    for (final r in RefundStatus.values) {
      if (r.value == s) return r;
    }
    return null;
  }
}

enum TimeSlotEnum {
  morning('MORNING'),
  afternoon('AFTERNOON'),
  evening('EVENING');

  const TimeSlotEnum(this.apiValue);
  final String apiValue;

  /// UI label for schedule booking screens.
  String get displayLabel {
    switch (this) {
      case TimeSlotEnum.morning:
        return 'Morning (8am - 12pm)';
      case TimeSlotEnum.afternoon:
        return 'Afternoon (12pm - 5pm)';
      case TimeSlotEnum.evening:
        return 'Evening (5pm - 9:30pm)';
    }
  }

  static TimeSlotEnum? fromApiValue(String? raw) {
    final s = raw?.trim().toUpperCase();
    if (s == null || s.isEmpty) return null;
    for (final t in TimeSlotEnum.values) {
      if (t.apiValue == s) return t;
    }
    return null;
  }

  static TimeSlotEnum? fromDisplayLabel(String? raw) {
    final s = raw?.trim();
    if (s == null || s.isEmpty) return null;
    for (final t in TimeSlotEnum.values) {
      if (t.displayLabel == s) return t;
    }
    return null;
  }
}

enum PaymentMethods {
  card(1),
  applePay(2),
  googlePay(3),
  affirm(4);

  const PaymentMethods(this.id);
  final int id;

  static PaymentMethods? fromId(int? id) {
    if (id == null) return null;
    for (final m in PaymentMethods.values) {
      if (m.id == id) return m;
    }
    return null;
  }
}

enum MessageType {
  text('text'),
  file('file'),
  image('image'),
  document('document'),
  mixed('mixed');

  const MessageType(this.value);
  final String value;

  static MessageType? fromValue(String? raw) {
    final s = raw?.trim().toLowerCase();
    if (s == null || s.isEmpty) return null;
    for (final m in MessageType.values) {
      if (m.value == s) return m;
    }
    return null;
  }
}

/// Subscription package length in days (backend constant).
abstract final class PackageDurations {
  static const int monthly = 30;
  static const int sixMonths = 180;
  static const int yearly = 365;
}

enum PaymentStatus {
  pending('pending'),
  processing('processing'),
  completed('completed'),
  failed('failed'),
  cancelled('cancelled'),
  refunded('refunded'),
  partiallyPaid('partially_paid'),
  succeeded('SUCCEEDED');

  const PaymentStatus(this.value);
  final String value;

  static PaymentStatus? fromValue(String? raw) {
    if (raw == null) return null;
    final s = raw.trim();
    if (s.isEmpty) return null;
    if (s == 'SUCCEEDED') return PaymentStatus.succeeded;
    final lower = s.toLowerCase();
    for (final p in PaymentStatus.values) {
      if (p.value.toLowerCase() == lower) return p;
    }
    return null;
  }
}

enum BookingPaymentStatusEnum {
  pendingPayment(1),
  paidInEscrow(2),
  refundedToUserWallet(3),
  releasedToProviderWallet(4),
  extraPaymentPending(5),
  extraPaymentPaid(6),
  failed(7);

  const BookingPaymentStatusEnum(this.code);
  final int code;

  static BookingPaymentStatusEnum? fromCode(int? code) {
    if (code == null) return null;
    for (final s in BookingPaymentStatusEnum.values) {
      if (s.code == code) return s;
    }
    return null;
  }
}

enum TransactionType {
  payment('payment'),
  refund('refund'),
  installment('installment'),
  commission('commission'),
  charge('CHARGE');

  const TransactionType(this.value);
  final String value;

  static TransactionType? fromValue(String? raw) {
    if (raw == null) return null;
    final s = raw.trim();
    for (final t in TransactionType.values) {
      if (t.value == s || t.value.toLowerCase() == s.toLowerCase()) {
        return t;
      }
    }
    return null;
  }
}

enum WithdrawalStatus {
  pending('pending'),
  processing('processing'),
  completed('completed'),
  failed('failed'),
  cancelled('cancelled');

  const WithdrawalStatus(this.value);
  final String value;

  static WithdrawalStatus? fromValue(String? raw) {
    final s = raw?.trim().toLowerCase();
    if (s == null || s.isEmpty) return null;
    for (final w in WithdrawalStatus.values) {
      if (w.value == s) return w;
    }
    return null;
  }
}

enum WithdrawalMethod {
  stripePayout('stripe_payout'),
  bankTransfer('bank_transfer');

  const WithdrawalMethod(this.value);
  final String value;

  static WithdrawalMethod? fromValue(String? raw) {
    final s = raw?.trim().toLowerCase();
    if (s == null || s.isEmpty) return null;
    for (final w in WithdrawalMethod.values) {
      if (w.value == s) return w;
    }
    return null;
  }
}

enum PackageType {
  monthly('MONTHLY'),
  fourMonth('FOUR_MONTH'),
  fiveMonth('FIVE_MONTH'),
  sixMonth('SIX_MONTH'),
  sevenMonth('SEVEN_MONTH'),
  eightMonth('EIGHT_MONTH'),
  nineMonth('NINE_MONTH'),
  tenMonth('TEN_MONTH'),
  elevenMonth('ELEVEN_MONTH'),
  yearly('YEARLY');

  const PackageType(this.value);
  final String value;

  static PackageType? fromValue(String? raw) {
    final s = raw?.trim().toUpperCase();
    if (s == null || s.isEmpty) return null;
    for (final p in PackageType.values) {
      if (p.value == s) return p;
    }
    return null;
  }
}

enum PlatformType {
  web(1),
  android(2),
  iosApp(3);

  const PlatformType(this.id);
  final int id;

  static PlatformType? fromId(int? id) {
    if (id == null) return null;
    for (final p in PlatformType.values) {
      if (p.id == id) return p;
    }
    return null;
  }
}

/// PRIMARY / SECONDARY booking rows (not UI instant/schedule in [ServiceType]).
enum ApiBookingType {
  primary('PRIMARY'),
  secondary('SECONDARY');

  const ApiBookingType(this.apiValue);
  final String apiValue;

  static ApiBookingType? fromApiValue(String? raw) {
    final s = raw?.trim().toUpperCase();
    if (s == null || s.isEmpty) return null;
    for (final t in ApiBookingType.values) {
      if (t.apiValue == s) return t;
    }
    return null;
  }
}
