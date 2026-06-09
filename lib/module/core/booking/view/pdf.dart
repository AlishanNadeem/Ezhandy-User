import 'dart:typed_data';
import 'package:flutter/material.dart' as mt;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePdf {
  static Future<Uint8List> generate({
    required String invoiceNo,
    required String billTo,
    required List<Map<String, String>> costItems,
    required List<Map<String, String>> otherItems,
    String? subtotal,
    String? tax,
    String? total,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          // Invoice Header
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("INVOICE",
                  style: pw.TextStyle(
                      fontSize: 22, fontWeight: pw.FontWeight.bold)),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text("Invoice No: $invoiceNo"),
                  pw.Text("Date: ${DateTime.now().toString().split(" ").first}"),
                ],
              )
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Text("Bill to: $billTo",
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 20),

          // Cost Table
          pw.Text("Cost", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.Table.fromTextArray(
            headers: ["Item", "Description", "Price"],
            data: costItems
                .map((item) => [
                      item['item']!,
                      item['description']!,
                      item['price']!,
                    ])
                .toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            border: pw.TableBorder.all(width: 0.5),
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              2: pw.Alignment.centerRight,
            },
            columnWidths: {
              0: const pw.FlexColumnWidth(2), // Item
              1: const pw.FlexColumnWidth(5), // Description
              2: const pw.FlexColumnWidth(3), // Price (wider now)
            },
          ),

          pw.SizedBox(height: 20),

          // Other Table
          pw.Text("Other", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.Table.fromTextArray(
            headers: ["Item", "Description", "Price", "Amount"],
            data: otherItems
                .map((item) => [
                      item['item']!,
                      item['description']!,
                      item['price']!,
                      item['amount']!,
                    ])
                .toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            border: pw.TableBorder.all(width: 0.5),
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.centerRight,
            },
            columnWidths: {
              0: const pw.FlexColumnWidth(2), // Item
              1: const pw.FlexColumnWidth(4), // Description
              2: const pw.FlexColumnWidth(2), // Price
              3: const pw.FlexColumnWidth(2), // Amount
            },
          ),

          pw.SizedBox(height: 20),

          if (subtotal != null) ...[
            pw.SizedBox(height: 12),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text('Sub Total: $subtotal'),
            ),
          ],
          if (tax != null) ...[
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text('Tax: $tax'),
            ),
          ],
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('Total: ',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text(
                total ?? _calculateTotal(costItems, otherItems),
                style: pw.TextStyle(
                    fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );

    return pdf.save();
  }

  static String _calculateTotal(
      List<Map<String, String>> costItems, List<Map<String, String>> otherItems) {
    double total = 0;
    for (var c in costItems) {
      total += double.tryParse(c['price']!.replaceAll("\$", "")) ?? 0;
    }
    for (var o in otherItems) {
      total += double.tryParse(o['amount']!.replaceAll("\$", "")) ?? 0;
    }
    return "${total.toStringAsFixed(2)}\$";
  }
}
