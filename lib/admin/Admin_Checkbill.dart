import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:workshop2test/Text/my_text.dart';

class Admin_CheckBill extends StatefulWidget {
  const Admin_CheckBill({super.key});

  @override
  State<Admin_CheckBill> createState() => _Admin_CheckBillState();
}

class _Admin_CheckBillState extends State<Admin_CheckBill> {
  // สมมติข้อมูลการสั่งซื้อ
  final List<Map<String, dynamic>> orders = [
    {
      'table': '1',
      'date': '2023-10-01',
      'orderNumber': '123',
      'total': '500',
      'paymentStatus': 'Paid',
      'receipt': 'View'
    },
    // เพิ่มออเดอร์ตามต้องการ
  ];

  // ฟังก์ชันแสดงและพิมพ์ใบเสร็จ
  void _showAndPrintReceipt(String orderNumber) {
    final String receiptImagePath = 'assets/receipt.jpg';
    _showReceiptImage(receiptImagePath);
    _printReceipt(receiptImagePath);
  }

  // แสดงรูปภาพใบเสร็จ
  void _showReceiptImage(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(imagePath),
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

  // พิมพ์ใบเสร็จ
  void _printReceipt(String imagePath) async {
    final pdf = pw.Document();
    final image = (await rootBundle.load(imagePath)).buffer.asUint8List();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตรวจสอบบิล'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double tableWidth = constraints.maxWidth * 0.93;
            double tableHeight = constraints.maxHeight * 0.7;

            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: tableWidth,
                height: tableHeight,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 184, 65, 26)),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor:
                        Colors.transparent, // ทำให้ divider สีเดียวกับพื้นหลัง
                    dataTableTheme: DataTableThemeData(
                      headingRowColor: MaterialStateProperty.all(
                          const Color.fromARGB(137, 237, 99, 53)),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                            label: Text('โต๊ะ', style: MyText.buttonpayment)),
                        DataColumn(
                            label: Text('วันที่สั่ง',
                                style: MyText.buttonpayment)),
                        DataColumn(
                            label: Text('เลขออเดอร์',
                                style: MyText.buttonpayment)),
                        DataColumn(
                            label:
                                Text('ยอดสุทธิ', style: MyText.buttonpayment)),
                        DataColumn(
                            label: Text('การชำระเงิน',
                                style: MyText.buttonpayment)),
                        DataColumn(label: Text('                                ')),
                      ],
                      rows: orders.map<DataRow>((order) {
                        return DataRow(
                          cells: [
                            DataCell(Text(order['table'])),
                            DataCell(Text(order['date'])),
                            DataCell(Text(order['orderNumber'])),
                            DataCell(Text(order['total'])),
                            DataCell(Text(order['paymentStatus'])),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize
                                    .min, // ใช้เพื่อกำหนดให้ Row มีขนาดตามปุ่มภายใน
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.tabelGreen),
                                      borderRadius: BorderRadius.circular(
                                          4), // ปรับความโค้งของขอบตามที่คุณต้องการ
                                    ),
                                    child: SizedBox(
                                      width: 130.0, // กำหนดความกว้างของปุ่ม
                                      height: 40.0, // กำหนดความสูงของปุ่ม
                                      child: TextButton(
                                        onPressed: () {
                                          // Logic สำหรับปุ่มยืนยัน
                                          print(
                                              'Confirming order ${order['orderNumber']}');
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: AppColors.tabelGreen,
                                          backgroundColor:
                                              Colors.white, // สีพื้นหลังของปุ่ม
                                          padding: const EdgeInsets.symmetric(
                                            vertical:
                                                5.0, // ปรับตามความหนาของปุ่มที่คุณต้องการ
                                            horizontal:
                                                3.0, // ปรับตามความกว้างของปุ่มที่คุณต้องการ
                                          ),
                                        ),
                                        child: const Text(
                                          'ยืนยันการชำระเงิน',
                                          style: TextStyle(
                                            fontSize:
                                                16.0,fontWeight: FontWeight.bold // ตั้งค่าขนาดตัวอักษรที่นี่
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                      width:
                                          8), // ใช้เพื่อเว้นระยะห่างระหว่างปุ่ม
                                  SizedBox(
                                    width: 100.0, // กำหนดความกว้างของปุ่ม
                                    height: 40.0, // กำหนดความสูงของปุ่ม
                                    child: TextButton(
                                      onPressed: () {
                                        _showAndPrintReceipt(
                                            order['orderNumber']);
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: AppColors.tabelGreen,
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'ใบเสร็จ',
                                            style: TextStyle(
                                              fontSize:
                                                  14.0, // ตั้งค่าขนาดตัวอักษรที่นี่
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.receipt, size: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppColors {
  static const Color primaryColor = Color(0xFF0E4E89);
  static const Color secondaryColor = Color(0xFF026D81);
  static const Color errorColor = Color(0xFFB00020);
  static const Color errorColor02 = Color(0xFFBBBBBB);
  static const Color errorColorOrenc = Color(0xFFED6335);
  static const Color tabelOn = Color(0xFFECAE7D);
  static const Color tabelOff = Color(0xFF8DB5AD);
  static const Color tabelGreen = Color(0xFF8DB5AD);
  static const Color buttonEdit = Color(0xFFEEB75D);
  static const Color colum = Color(0xFFED6335);
}
