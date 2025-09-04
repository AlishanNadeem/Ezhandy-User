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
import 'package:printing/printing.dart';
// import 'invoice_pdf.dart';

class InvoiceScreen extends StatelessWidget {
  final List<Map<String, String>> costItems = [
    {
      "item": "Pool Cleaning",
      "description":
          "Includes vacuuming, skimming debris, and brushing pool walls and tiles.",
      "price": "10000\$"
    },
    {
      "item": "Water Balancing and Chemical Testing",
      "description":
          "Testing and adjusting water chemistry to ensure safe pH, chlorine, and alkalinity levels.",
      "price": "10000\$"
    },
    {
      "item": "Filter Cleaning and Maintenance",
      "description":
          "Cleaning or replacing pool filters to ensure proper water circulation and filtration.",
      "price": "1000\$"
    },
    {
      "item": "Water Balancing and Chemical Testing",
      "description":
          "Testing and adjusting water chemistry to ensure safe pH, chlorine, and alkalinity levels.",
      "price": "10000\$"
    },
    {
      "item": "Filter Cleaning and Maintenance",
      "description":
          "Cleaning or replacing pool filters to ensure proper water circulation and filtration.",
      "price": "1000\$"
    },
    {
      "item": "Water Balancing and Chemical Testing",
      "description":
          "Testing and adjusting water chemistry to ensure safe pH, chlorine, and alkalinity levels.",
      "price": "10000\$"
    },
    {
      "item": "Filter Cleaning and Maintenance",
      "description":
          "Cleaning or replacing pool filters to ensure proper water circulation and filtration.",
      "price": "1000\$"
    },
  ];

  final List<Map<String, String>> otherItems = [
    {
      "item": "Labour",
      "description": "-",
      "price": "10000\$",
      "amount": "1000\$"
    },
    {
      "item": "Equipment",
      "description": "-",
      "price": "10000\$",
      "amount": "14000\$"
    },
    {
      "item": "Equipment",
      "description": "-",
      "price": "1000\$",
      "amount": "10\$"
    },
  ];

  InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      leading: AssetPath.backIcon,
      onclickLead: () {
        Get.back();
      },
      // appBarheight: 50.h,
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
            _buildCostTable(),
            const SizedBox(height: 20),
              CustomText(
              text: AppStrings.other,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
            10.verticalSpace,
            _buildOtherTable(),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: 14000\$",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            25.verticalSpace
          ],
        ),
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
              invoiceNo: "0000001",
              billTo: "CLIENT NAME",
              costItems: costItems,
              otherItems: otherItems,
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
        const Text("INVOICE",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Invoice No: 0000001"),
                Text("Bill to: CLIENT NAME"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text("Date: 12 October, 2025"),
              ],
            ),
          ],
        ),
      ],
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
        _buildHeaderRow(["Item", "Description", "Price"]),
        ...costItems.map((item) => TableRow(
              decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
              children: [
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(item["item"]!)),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(item["description"]!)),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(item["price"]!, textAlign: TextAlign.right)),
              ],
            ))
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
        _buildHeaderRow(["Item", "Description", "Price", "Amount"]),
        ...otherItems.map((item) => TableRow(
              decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
              children: [
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(item["item"]!)),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(item["description"]!)),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(item["price"]!, textAlign: TextAlign.right)),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(item["amount"]!, textAlign: TextAlign.right)),
              ],
            ))
      ],
    );
  }

  TableRow _buildHeaderRow(List<String> headers) {
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
      children: headers
          .map((h) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(h,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ))
          .toList(),
    );
  }
}
