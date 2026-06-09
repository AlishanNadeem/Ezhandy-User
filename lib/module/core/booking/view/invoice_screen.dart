import 'package:ezhandy_user/module/core/booking/model/booking_invoice_model.dart';
import 'package:ezhandy_user/module/core/booking/routing_arguments/invoice_routing_arguments.dart';
import 'package:ezhandy_user/module/core/booking/view/pdf.dart';
import 'package:ezhandy_user/utils/app_padding.dart';
import 'package:ezhandy_user/utils/app_strings.dart';
import 'package:ezhandy_user/utils/asset_path.dart';
import 'package:ezhandy_user/widgets/button_widgets/custom_button.dart';
import 'package:ezhandy_user/widgets/logo_and_backgrounds/background.dart';
import 'package:ezhandy_user/widgets/text_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

class InvoiceScreen extends StatelessWidget {
  final BookingInvoice invoice;
  final String billToName;

  const InvoiceScreen({
    required this.invoice,
    required this.billToName,
    super.key,
  });

  factory InvoiceScreen.fromArgs(InvoiceRoutingArgument args) {
    return InvoiceScreen(
      invoice: args.invoice,
      billToName: args.billToName,
    );
  }

  List<Map<String, String>> get _costItems => invoice.items
      .map(
        (item) => {
          'item': item.description,
          'description': item.qty > 0
              ? 'Qty: ${item.qty} × \$${item.unitPrice}'
              : '—',
          'price': _formatMoney(item.total),
        },
      )
      .toList();

  List<Map<String, String>> get _otherItems {
    if (!invoice.hasExtraCharge) return [];
    return [
      {
        'item': AppStrings.otherCharges,
        'description':
            invoice.extraNote.trim().isNotEmpty ? invoice.extraNote : '—',
        'price': _formatMoney(invoice.extraAmount),
        'amount': _formatMoney(invoice.extraAmount),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: Get.back,
      title: AppStrings.invoice,
      actionWidget: downloadBtnWidget(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            CustomText(
              text: AppStrings.cost,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
            10.verticalSpace,
            _costItems.isEmpty
                ? _emptyTableMessage()
                : _buildCostTable(),
            if (_otherItems.isNotEmpty) ...[
              const SizedBox(height: 20),
              CustomText(
                text: AppStrings.other,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              10.verticalSpace,
              _buildOtherTable(),
            ],
            const SizedBox(height: 20),
            _buildSummary(),
            25.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _emptyTableMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: CustomText(
        text: 'No line items',
        color: Colors.grey,
        fontSize: 12.sp,
      ),
    );
  }

  Padding downloadBtnWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: AppPadding.padding12),
      child: CustomButton(
          width: 140.w,
          onclick: () async {
            final pdfFile = await InvoicePdf.generate(
              invoiceNo: invoice.id.toString().padLeft(7, '0'),
              billTo: billToName,
              costItems: _costItems,
              otherItems: _otherItems,
              subtotal: _formatMoney(invoice.subtotal),
              tax: _formatMoney(invoice.tax),
              total: _formatMoney(invoice.total),
            );
            await Printing.layoutPdf(onLayout: (_) => pdfFile);
          },
          text: AppStrings.downloadPdf),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('INVOICE',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Invoice No: ${invoice.id.toString().padLeft(7, '0')}'),
                Text('Bill to: ${billToName.isNotEmpty ? billToName : '—'}'),
                if (invoice.bookingId > 0)
                  Text('Booking ID: #${invoice.bookingId}'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Date: ${_formatDate(invoice.createdAt)}'),
                Text(
                  'Status: ${invoice.status}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _summaryRow(AppStrings.subtotal, _formatMoney(invoice.subtotal)),
        _summaryRow(
          '${AppStrings.tax} (${invoice.taxRate}%)',
          _formatMoney(invoice.tax),
        ),
        if (invoice.hasExtraCharge)
          _summaryRow(
            AppStrings.otherCharges,
            _formatMoney(invoice.extraAmount),
          ),
        const SizedBox(height: 8),
        Text(
          'Total: ${_formatMoney(invoice.total)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$label: $value', style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _buildCostTable() {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(2),
      },
      children: [
        _buildHeaderRow(['Item', 'Description', 'Price']),
        ..._costItems.map(
          (item) => TableRow(
            decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item['item']!)),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item['description']!)),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item['price']!, textAlign: TextAlign.right)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtherTable() {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        _buildHeaderRow(['Item', 'Description', 'Price', 'Amount']),
        ..._otherItems.map(
          (item) => TableRow(
            decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item['item']!)),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item['description']!)),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item['price']!, textAlign: TextAlign.right)),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(item['amount']!, textAlign: TextAlign.right)),
            ],
          ),
        ),
      ],
    );
  }

  TableRow _buildHeaderRow(List<String> headers) {
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
      children: headers
          .map(
            (h) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text(h, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
          .toList(),
    );
  }

  String _formatMoney(String amount) {
    final v = double.tryParse(amount);
    if (v == null) return '\$$amount';
    return '\$${v.toStringAsFixed(2)}';
  }

  String _formatDate(String value) {
    final dt = DateTime.tryParse(value);
    if (dt == null) return value;
    return DateFormat('dd MMMM, yyyy').format(dt.toLocal());
  }
}
