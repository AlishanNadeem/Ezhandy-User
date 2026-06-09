import 'package:ezhandy_user/module/core/booking/model/booking_invoice_model.dart';

class InvoiceRoutingArgument {
  final BookingInvoice invoice;
  final String billToName;

  InvoiceRoutingArgument({
    required this.invoice,
    required this.billToName,
  });
}
