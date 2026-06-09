class BookingInvoiceItem {
  final int qty;
  final String description;
  final String unitPrice;
  final String total;

  BookingInvoiceItem({
    required this.qty,
    required this.description,
    required this.unitPrice,
    required this.total,
  });

  factory BookingInvoiceItem.fromJson(Map<String, dynamic> json) {
    return BookingInvoiceItem(
      qty: _int(json['qty']),
      description: json['description']?.toString() ?? '',
      unitPrice: _amount(json['unitPrice']),
      total: _amount(json['total']),
    );
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _amount(dynamic value) {
    if (value == null) return '0';
    return value.toString();
  }
}

class BookingInvoice {
  final int id;
  final int bookingId;
  final String userId;
  final String providerId;
  final List<BookingInvoiceItem> items;
  final String subtotal;
  final String tax;
  final String taxRate;
  final String total;
  final String extraAmount;
  final String extraNote;
  final bool extraPaid;
  final String status;
  final String? pdfPath;
  final String createdAt;
  final String updatedAt;

  BookingInvoice({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.providerId,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.taxRate,
    required this.total,
    required this.extraAmount,
    required this.extraNote,
    required this.extraPaid,
    required this.status,
    this.pdfPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingInvoice.fromJson(Map<String, dynamic> json) {
    return BookingInvoice(
      id: _int(json['id']),
      bookingId: _int(json['bookingId']),
      userId: json['userId']?.toString() ?? '',
      providerId: json['providerId']?.toString() ?? '',
      items: _parseItems(json['items']),
      subtotal: _amount(json['subtotal']),
      tax: _amount(json['tax']),
      taxRate: _amount(json['taxRate']),
      total: _amount(json['total']),
      extraAmount: _amount(json['extraAmount']),
      extraNote: json['extraNote']?.toString() ?? '',
      extraPaid: json['extraPaid'] == true,
      status: json['status']?.toString() ?? '',
      pdfPath: json['pdfPath']?.toString(),
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  bool get hasExtraCharge {
    final v = double.tryParse(extraAmount) ?? 0;
    return v > 0 || extraNote.trim().isNotEmpty;
  }

  static List<BookingInvoiceItem> _parseItems(dynamic raw) {
    if (raw is! List) return <BookingInvoiceItem>[];
    final items = <BookingInvoiceItem>[];
    for (final e in raw) {
      if (e is BookingInvoiceItem) {
        items.add(e);
      } else if (e is Map) {
        items.add(
          BookingInvoiceItem.fromJson(Map<String, dynamic>.from(e)),
        );
      }
    }
    return items;
  }

  static int _int(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _amount(dynamic value) {
    if (value == null) return '0';
    return value.toString();
  }

  /// Fallback when detail API has no `invoice` object (e.g. status 6).
  factory BookingInvoice.fromBookingDetail({
    required int bookingId,
    required String totalAmount,
    required String? durationMinutes,
    required String userId,
    required String providerId,
    required String? serviceTitle,
    required String visitCharges,
    required String hourlyRate,
    required String createdAt,
    required bool isPaid,
  }) {
    final items = <BookingInvoiceItem>[];
    final visit = visitCharges.trim();
    if (visit.isNotEmpty && visit != '0') {
      items.add(
        BookingInvoiceItem(
          qty: 1,
          description: 'Visit Charges',
          unitPrice: visit,
          total: visit,
        ),
      );
    }

    final minutes = int.tryParse(durationMinutes?.trim() ?? '') ?? 0;
    final hourly = double.tryParse(hourlyRate) ?? 0;
    if (minutes > 0 && hourly > 0) {
      final labourTotal = (minutes / 60 * hourly).toStringAsFixed(2);
      items.add(
        BookingInvoiceItem(
          qty: 1,
          description: serviceTitle?.isNotEmpty == true
              ? '${serviceTitle!} (${_formatHours(minutes)}h × \$$hourlyRate/hr)'
              : 'Labour (${_formatHours(minutes)}h × \$$hourlyRate/hr)',
          unitPrice: hourlyRate,
          total: labourTotal,
        ),
      );
    }

    if (items.isEmpty && totalAmount.isNotEmpty) {
      items.add(
        BookingInvoiceItem(
          qty: 1,
          description: 'Service charges',
          unitPrice: totalAmount,
          total: totalAmount,
        ),
      );
    }

    return BookingInvoice(
      id: 0,
      bookingId: bookingId,
      userId: userId,
      providerId: providerId,
      items: items,
      subtotal: totalAmount,
      tax: '0',
      taxRate: '0',
      total: totalAmount,
      extraAmount: '0',
      extraNote: '',
      extraPaid: isPaid,
      status: isPaid ? 'paid' : 'pending',
      createdAt: createdAt,
      updatedAt: createdAt,
    );
  }

  static String _formatHours(int minutes) {
    final hours = minutes / 60;
    return hours.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
  }
}
