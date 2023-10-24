import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Admin_Dashboard extends StatefulWidget {
  @override
  _Admin_DashboardState createState() => _Admin_DashboardState();
}

class _Admin_DashboardState extends State<Admin_Dashboard> {
  List<ChartData> chartData = [
    ChartData('ก.ย.', 35222),
    ChartData('ต.ค.', 40351),
    ChartData('พ.ย.', 20146),
    ChartData('ธ.ค.', 27146),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: 0.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          children: [
            // ส่วนบน
            Expanded(
              child: Row(
                children: [
                  // ส่วนบนซ้าย
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 400,
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(165, 237, 99, 53),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 50.0), // ตั้งค่าระยะห่างจากซ้าย 10 pixels
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start, // ให้ข้อความชิดซ้าย
                            children: [
                              Text(
                                'จำนวนออเดอร์',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '150 รายการ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 25),
                  // ส่วนบนขวา
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 400,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white, // ตั้งค่าสีพื้นหลังที่นี่
                          border: Border.all(color: AppColors.yewlo, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 50.0), // ตั้งค่าระยะห่างจากซ้าย 10 pixels
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start, // ให้ข้อความชิดซ้าย
                            children: [
                              Text(
                                'ยอดขายวันนี้',
                                style: TextStyle(
                                    color: AppColors.yewlo,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '10,458',
                                    style: TextStyle(
                                        color: AppColors.yewlo,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' บาท',
                                    style: TextStyle(
                                        color: AppColors.yewlo,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            ////////////////////////////////////////////////////////////////////

            // ส่วนล่าง
            Expanded(
              child: Row(
                children: [
                  // ส่วนล่างซ้าย
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // ชิดซ้ายของ Column
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 50.0, top: 8.0, right: 8.0),
                          child: Text(
                            'เมนูขายดี',
                            style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              // ฝั่งซ้าย: เมนู
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // ชิดซ้ายของ Column ที่นี่
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Text('เมนู',
                                          style: TextStyle(
                                              color: AppColors.textoder,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30)),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Text(
                                        'ข้าวไข่เจียวหมูสับ',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: AppColors.textoder),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Text(
                                        'ข้าวไข่เจียวหมูสับ',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: AppColors.textoder),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Text(
                                        'ข้าวไข่เจียวหมูสับ',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: AppColors.textoder),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Text(
                                        'ข้าวไข่เจียวหมูสับ',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: AppColors.textoder),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),

                              // ฝั่งขวา: จำนวน
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('ออดอร์',
                                        style: TextStyle(
                                            color: AppColors.textoder,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30)),
                                    SizedBox(height: 10),
                                    // คุณสามารถเพิ่มตัวเลขที่นี่
                                    Text(
                                      '150',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: AppColors.textoder),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      '141',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: AppColors.textoder),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      '130',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: AppColors.textoder),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      '105',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: AppColors.textoder),
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // เส้นแบ่ง
                  const VerticalDivider(
                      color: AppColors.secondaryColor, width: 1.0, thickness: 2.0),

                  // ส่วนล่างขวา (กราฟ)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                          child: Text(
                            'ยอดขายรายเดือน',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <ColumnSeries<ChartData, String>>[
                              ColumnSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.month,
                                yValueMapper: (ChartData data, _) => data.sales,
                                color: AppColors.tabelGreen,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    labelAlignment: ChartDataLabelAlignment
                                        .top, // จัดตำแหน่ง label ไว้ด้านบนของแท่งกราฟ
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            16) // คุณสามารถปรับเปลี่ยน style ของ label ได้ตามต้องการ
                                    ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String month;
  final double sales;

  ChartData(this.month, this.sales);
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
  static const Color photo = Color(0xFFD9D9D9);
  static const Color yewlo = Color(0xFFEEB75D);
  static const Color textoder = Color(0xFF6B6B6B);
}
