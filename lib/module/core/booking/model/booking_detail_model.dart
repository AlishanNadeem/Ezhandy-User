import 'package:ezhandy_user/module/core/booking/model/booking_invoice_model.dart';

class BookingPerson {
  final String id;
  final String fullName;
  final String email;
  final String mobileNumber;
  final String? profileImage;
  final String? address;
  final String? latitude;
  final String? longitude;

  BookingPerson({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    this.profileImage,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory BookingPerson.fromJson(Map<String, dynamic> json) {
    return BookingPerson(
      id: json['id']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      mobileNumber: json['mobileNumber']?.toString() ?? '',
      profileImage: json['profileImage']?.toString(),
      address: json['address']?.toString(),
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
    );
  }
}

class BookingServiceInfo {
  final int id;
  final String title;
  final String description;
  final String visitCharges;
  final String hourlyRate;
  final bool isQuickService;

  BookingServiceInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.visitCharges,
    required this.hourlyRate,
    required this.isQuickService,
  });

  factory BookingServiceInfo.fromJson(Map<String, dynamic> json) {
    return BookingServiceInfo(
      id: _int(json['id']),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      visitCharges: json['visitCharges']?.toString() ?? '0',
      hourlyRate: json['hourlyRate']?.toString() ?? '0',
      isQuickService: json['isQuickService'] == true,
    );
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class WorkDocumentItem {
  final int id;
  final String imagePath;
  final String? title;
  final String? description;

  WorkDocumentItem({
    required this.id,
    required this.imagePath,
    this.title,
    this.description,
  });

  factory WorkDocumentItem.fromJson(Map<String, dynamic> json) {
    return WorkDocumentItem(
      id: _int(json['id']),
      imagePath: json['imagePath']?.toString() ?? '',
      title: json['title']?.toString(),
      description: json['description']?.toString(),
    );
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class BookingWorkDocuments {
  final List<WorkDocumentItem> before;
  final List<WorkDocumentItem> after;

  BookingWorkDocuments({required this.before, required this.after});

  factory BookingWorkDocuments.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return BookingWorkDocuments(
        before: <WorkDocumentItem>[],
        after: <WorkDocumentItem>[],
      );
    }
    return BookingWorkDocuments(
      before: _parseList(json['before']),
      after: _parseList(json['after']),
    );
  }

  static List<WorkDocumentItem> _parseList(dynamic raw) {
    if (raw is! List) return <WorkDocumentItem>[];
    final items = <WorkDocumentItem>[];
    for (final e in raw) {
      if (e is WorkDocumentItem) {
        items.add(e);
      } else if (e is Map) {
        items.add(
          WorkDocumentItem.fromJson(Map<String, dynamic>.from(e)),
        );
      }
    }
    return items;
  }

  /// Safe path extraction from API JSON (avoids [List<dynamic>] cast issues).
  static List<String> imagePathsFromJson(
    Map<String, dynamic>? json,
    String key,
  ) {
    if (json == null) return <String>[];
    return imagePathsFromRaw(json[key]);
  }

  static List<String> imagePathsFromRaw(dynamic raw) {
    if (raw is! List) return <String>[];
    final paths = <String>[];
    for (final e in raw) {
      if (e is WorkDocumentItem) {
        if (e.imagePath.isNotEmpty) paths.add(e.imagePath);
      } else if (e is Map) {
        final path = e['imagePath']?.toString() ?? '';
        if (path.isNotEmpty) paths.add(path);
      }
    }
    return paths;
  }

  bool get hasDocuments => before.isNotEmpty || after.isNotEmpty;
}

class BookingDetail {
  final int id;
  final int status;
  final String statusLabel;
  final String bookingDate;
  final List<String> timeSlots;
  final String totalAmount;
  final String? duration;
  final String bookingType;
  final String notes;
  final String? statusReason;
  final String? reportMessage;
  final String? reportType;
  final bool isPaid;
  final String? paymentId;
  final String createdAt;
  final BookingPerson? user;
  final BookingPerson? provider;
  final BookingServiceInfo? service;
  final BookingWorkDocuments workDocuments;
  final List<String> beforeImagePaths;
  final List<String> afterImagePaths;
  final BookingInvoice? invoice;

  BookingDetail({
    required this.id,
    required this.status,
    required this.statusLabel,
    required this.bookingDate,
    required this.timeSlots,
    required this.totalAmount,
    this.duration,
    required this.bookingType,
    required this.notes,
    this.statusReason,
    this.reportMessage,
    this.reportType,
    required this.isPaid,
    this.paymentId,
    required this.createdAt,
    this.user,
    this.provider,
    this.service,
    required this.workDocuments,
    required this.beforeImagePaths,
    required this.afterImagePaths,
    this.invoice,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) {
    final slots = json['timeSlots'];
    final workDocsJson = json['workDocuments'] is Map
        ? Map<String, dynamic>.from(json['workDocuments'] as Map)
        : null;
    return BookingDetail(
      id: _int(json['id']),
      status: _int(json['status']),
      statusLabel: json['statusLabel']?.toString() ?? '',
      bookingDate: json['bookingDate']?.toString() ?? '',
      timeSlots: slots is List
          ? slots.map((e) => e.toString()).toList()
          : <String>[],
      totalAmount: json['totalAmount']?.toString() ?? '0',
      duration: json['duration']?.toString(),
      bookingType: json['bookingType']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      statusReason: json['statusReason']?.toString(),
      reportMessage: json['message']?.toString(),
      reportType: json['reportType']?.toString(),
      isPaid: json['isPaid'] == true,
      paymentId: json['paymentId']?.toString(),
      createdAt: json['createdAt']?.toString() ?? '',
      user: json['user'] is Map
          ? BookingPerson.fromJson(
              Map<String, dynamic>.from(json['user'] as Map),
            )
          : null,
      provider: json['provider'] is Map
          ? BookingPerson.fromJson(
              Map<String, dynamic>.from(json['provider'] as Map),
            )
          : null,
      service: json['service'] is Map
          ? BookingServiceInfo.fromJson(
              Map<String, dynamic>.from(json['service'] as Map),
            )
          : null,
      workDocuments: BookingWorkDocuments.fromJson(workDocsJson),
      beforeImagePaths:
          BookingWorkDocuments.imagePathsFromJson(workDocsJson, 'before'),
      afterImagePaths:
          BookingWorkDocuments.imagePathsFromJson(workDocsJson, 'after'),
      invoice: _parseInvoice(json),
    );
  }

  static BookingInvoice? _parseInvoice(Map<String, dynamic> json) {
    dynamic raw = json['invoice'] ?? json['bookingInvoice'];
    if (raw is List && raw.isNotEmpty) {
      final first = raw.first;
      if (first is Map) raw = first;
    }
    if (raw is Map) {
      return BookingInvoice.fromJson(Map<String, dynamic>.from(raw));
    }
    return null;
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
