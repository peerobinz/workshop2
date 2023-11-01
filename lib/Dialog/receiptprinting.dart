import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReceiptViewingAndPrinting extends StatelessWidget {
  final String orderNumber;
  final String receiptImagePath;

  const ReceiptViewingAndPrinting({
    Key? key,
    required this.orderNumber,
    this.receiptImagePath = 'assets/receipt.jpg', // ตั้งค่าเส้นทางรูปภาพใบเสร็จของคุณ
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.receipt),
          label: const Text('ใบเสร็จ'),
          onPressed: () => _showReceiptImage(context),
        ),
        TextButton.icon(
          icon: const Icon(Icons.print),
          label: const Text('พิมพ์ใบเสร็จ'),
          onPressed: () => _printReceipt(context),
        ),
      ],
    );
  }

  void _showReceiptImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(receiptImagePath), // หรือ Image.network ถ้ารูปภาพอยู่บนเว็บ
          actions: <Widget>[
            TextButton(
              child: const Text('ปิด'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _printReceipt(BuildContext context) async {
    final pdf = pw.Document();
    final image = (await rootBundle.load(receiptImagePath)).buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(image)),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
