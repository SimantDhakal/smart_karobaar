import 'package:carousel_slider/carousel_slider.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:law_dairy/components/flutter_charts/line_chart.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SummarizeScreen extends StatefulWidget {
  @override
  _SummarizeScreenState createState() => _SummarizeScreenState();
}

class _SummarizeScreenState extends State<SummarizeScreen> {

  bool dailySummary, weeklySummary;

  // table data
  final desktopSalesData = [
    new LinearSales(0, 5),
    new LinearSales(1, 25),
    new LinearSales(2, 100),
    new LinearSales(3, 75),
  ];

  // total turnover
  final totalTurnOver = [
    new LinearSales(0, 5897899),
    new LinearSales(1, 3983939),
    new LinearSales(2, 7927383),
    new LinearSales(3, 6893839),
  ];

  final mobileSalesData = [
    new LinearSales(0, 10),
    new LinearSales(1, 50),
    new LinearSales(2, 200),
    new LinearSales(3, 150),
  ];

  getTotalTurnOver() {
    List<charts.Series<LinearSales, int>> series = [

      charts.Series(
        data: totalTurnOver,
        id: 'Tablet',
        colorFn: (_, __) => charts.Color.fromHex(code: "#2e8062"),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
      )
    ];
    return series;
  }

  _getSeriesData() {
    List<charts.Series<LinearSales, int>> series = [
      charts.Series(
        data: mobileSalesData,
        id: 'Tablet',
        colorFn: (_, __) => charts.Color.fromHex(code: "#2e8062"),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
      )
    ];
    return series;
  }


  @override
  void initState() {
    super.initState();
    setState(() {
      dailySummary = true;
      weeklySummary = false;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColor.darkModeBg,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/pattern1.png", height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Positioned(
              top: 0, right: 0, left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height + 250,
                child: Column(
                  children: <Widget>[
                    if (dailySummary == true)
                      SingleChildScrollView(
                          child: Container(
                            color: AppColor.darkModeBg,
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: MediaQuery.of(context).padding.top + 20.0),

                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (dailySummary == false) {
                                                  dailySummary = true;
                                                  weeklySummary = false;
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(12.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                                  border: Border.all(color:  Color.fromRGBO(46, 128, 98, 1), width: 1),
                                                  color: dailySummary ? Color.fromRGBO(46, 128, 98, 1) : Color.fromRGBO(57, 60, 66, 1)
                                              ),
                                              child: Text("Daily Summary", style:
                                              TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(width: 20.0),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (weeklySummary == false) {
                                                  dailySummary = false;
                                                  weeklySummary = true;
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(12.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                                                  border: Border.all(color: Color.fromRGBO(46, 128, 98, 1), width: 1),
                                                  color: weeklySummary ? Color.fromRGBO(46, 128, 98, 1) : Color.fromRGBO(57, 60, 66, 1)
                                              ),
                                              child: Text("Weekly Summary", style:
                                              TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                nepseIndexWidget(),
                                SizedBox(height: 12.0),

                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 360.0,
                                    // aspectRatio: 16/9,
                                    viewportFraction: 1,
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                  ),
                                  items: [1,2].map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        if (i == 1) {
                                          return topGainer();
                                        } else {
                                          return topLooser();
                                        }
                                      },
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )
                      )
                    else
                      SingleChildScrollView(
                        child: Container(
                          color: AppColor.darkModeBg,
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: MediaQuery.of(context).padding.top + 20.0),

                              Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (dailySummary == false) {
                                                dailySummary = true;
                                                weeklySummary = false;
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                                border: Border.all(color:  Color.fromRGBO(46, 128, 98, 1), width: 1),
                                                color: dailySummary ? Color.fromRGBO(46, 128, 98, 1) : Color.fromRGBO(57, 60, 66, 1)
                                            ),
                                            child: Text("Daily Summary", style:
                                            TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(width: 20.0),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (weeklySummary == false) {
                                                dailySummary = false;
                                                weeklySummary = true;
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                                                border: Border.all(color: Color.fromRGBO(46, 128, 98, 1), width: 1),
                                                color: weeklySummary ? Color.fromRGBO(46, 128, 98, 1) : Color.fromRGBO(57, 60, 66, 1)
                                            ),
                                            child: Text("Weekly Summary", style:
                                            TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 360.0,
                                  // aspectRatio: 16/9,
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                ),
                                items: [1,2].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      if (i == 1) {
                                        return Container(
                                          color: AppColor.darkModeBg,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 0.0),
                                                  width: MediaQuery.of(context).size.width - 25.0,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topRight,
                                                        end: Alignment.bottomLeft,
                                                        colors: [
                                                          Color.fromRGBO(46, 128, 98, 1),
                                                          Color.fromRGBO(64, 178, 135, 1),
                                                        ],
                                                      )
                                                  ),
                                                  // padding: EdgeInsets.only(top: 25.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                                                        child: Text("Weekly Turnover", style: TextStyle(color: Colors.grey[300], fontSize: 15.0, fontWeight: FontWeight.bold)),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(bottom: 7.0),
                                                        child: Text("2021/10/17 - 2021/11/17", style: TextStyle(color: Colors.grey[300], fontSize: 13.0, fontWeight: FontWeight.normal)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.only(bottom: 8.0, top: 15.0),
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(57, 60, 66, 1),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                ),

                                                child: Text("Total Turnover",
                                                    style: TextStyle(color: Colors.grey[200], fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                    // color: Colors.grey[200],
                                                    color: Color.fromRGBO(57, 60, 66, 1),
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                  ),
                                                  height: 250.0,
                                                  child: Container(
                                                    margin: EdgeInsets.all(8.0),
                                                    color: Colors.white,
                                                    child: Expanded(
                                                      child: new charts.NumericComboChart(getTotalTurnOver(),
                                                        animate: true,
                                                      ),
                                                    ),
                                                  )
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          color: AppColor.darkModeBg,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 0.0),
                                                  width: MediaQuery.of(context).size.width - 25.0,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topRight,
                                                        end: Alignment.bottomLeft,
                                                        colors: [
                                                          Color.fromRGBO(46, 128, 98, 1),
                                                          Color.fromRGBO(64, 178, 135, 1),
                                                        ],
                                                      )
                                                  ),
                                                  // padding: EdgeInsets.only(top: 25.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                                                        child: Text("Weekly Update", style: TextStyle(color: Colors.grey[300], fontSize: 15.0, fontWeight: FontWeight.bold)),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(bottom: 7.0),
                                                        child: Text("(14th Nov to 18th Nov 2021)", style: TextStyle(color: Colors.grey[300], fontSize: 13.0, fontWeight: FontWeight.normal)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.only(bottom: 8.0, top: 15.0),
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(57, 60, 66, 1),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                ),

                                                child: Text("Turnover in Rs.",
                                                    style: TextStyle(color: Colors.grey[200], fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                    // color: Colors.grey[200],
                                                    color: Color.fromRGBO(57, 60, 66, 1),
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                  ),
                                                  height: 250.0,
                                                  child: Container(
                                                    margin: EdgeInsets.all(8.0),
                                                    color: Colors.white,
                                                    child: Expanded(
                                                      child: new charts.NumericComboChart(_getSeriesData(),
                                                          animate: true,
                                                          defaultRenderer: new charts.LineRendererConfig(),
                                                          customSeriesRenderers: [
                                                            new charts.BarRendererConfig(
                                                                customRendererId: 'customBar')
                                                          ]),
                                                    ),
                                                  )
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }).toList(),
                              ),

                            ],
                          ),
                        ),
                      ),

                    if (weeklySummary == true)
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 15.0),
                              width: MediaQuery.of(context).size.width - 20.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color.fromRGBO(46, 128, 98, 1),
                                      Color.fromRGBO(64, 178, 135, 1),
                                    ],
                                  )
                              ),
                              // padding: EdgeInsets.only(top: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                                    child: Text("Index/Sub Index/Weekly Report", style: TextStyle(color: Colors.grey[300], fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 7.0),
                                    child: Text("2021/10/17 - 2021/11/17", style: TextStyle(color: Colors.grey[300], fontSize: 13.0, fontWeight: FontWeight.normal)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0.0, bottom: 10.0),
                              padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color.fromRGBO(51, 55, 62, 1),
                                      Color.fromRGBO(51, 55, 62, 1),
                                    ],
                                  )
                              ),
                              child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: DataTable(
                                    columnSpacing: 47.0,
                                    // sortAscending: sort,
                                    headingRowColor: MaterialStateProperty.all(Color(0xFF33373e)),
                                    columns: [
                                      DataColumn(
                                        label: Text('In/Sub', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.0)),
                                      ),
                                      DataColumn(
                                        label: Text('Opn', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.0)),
                                      ),
                                      DataColumn(
                                        label: InkWell(
                                          onTap: () {
                                            setState(() {
                                              // change ? change = false : change = true;
                                            });
                                          },
                                          child: Text('Cls', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.0)),
                                        ),
                                      ),
                                      DataColumn(
                                        label: InkWell(
                                          onTap: () {
                                            setState(() {
                                              // turnover ? turnover = false : turnover = true;
                                            });
                                          },
                                          child: Text('Chg', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.0)),
                                        ),
                                        numeric: true,
                                      )
                                    ],
                                    rows: List<DataRow>.generate(
                                        9, (index) {
                                      if (index == 1 || index == 3 || index == 7 || index == 8 || index == 10 || index == 13 || index == 15 || index == 18 || index == 20 ||
                                          index == 22 || index == 23 || index == 24 || index == 26) {
                                        return DataRow(color: MaterialStateProperty.all(Colors.white), cells: [
                                          DataCell(Text('Banking', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 14.0))),
                                          DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2), style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 14.0))),
                                          DataCell(Text((12 - (index + 5) % 14).toStringAsFixed(2)+"%", style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 14.0))),
                                          DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 14.0))),
                                        ]);
                                      } else {
                                        return DataRow(color: MaterialStateProperty.all(Colors.white), cells: [
                                          DataCell(Text('Hydropower', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 14.0))),
                                          DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2), style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 14.0))),
                                          DataCell(Text((12 - (index + 5) % 14).toStringAsFixed(2)+"%", style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 14.0))),
                                          DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 14.0))),
                                        ]);
                                      }
                                    }
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget topGainer() {
    return Container(
      // margin: EdgeInsets.only(right: 10.0, left: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("Top Gainer", style:
            TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(228, 230, 232, 1))),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blueGrey
            ),
            child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.blueGrey),
                columns: [
                  DataColumn(
                    label: Text('SYM', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Change', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Ch%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('LTP', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    numeric: true,
                  ),
                ],
                rows: List<DataRow>.generate(
                    5, (index) {
                  if (index == 1 || index == 3 || index == 7 || index == 8 || index == 10 || index == 13 || index == 15 || index == 18 || index == 20 ||
                      index == 22 || index == 23 || index == 24 || index == 26) {
                    return DataRow(color: MaterialStateProperty.all(Colors.white), cells: [
                      DataCell(Text('Joshi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2), style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text((12 - (index + 5) % 14).toStringAsFixed(2)+"%", style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
                    ]);
                  } else {
                    return DataRow(color: MaterialStateProperty.all(Colors.white), cells: [
                      DataCell(Text('GAH', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2), style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text((12 - (index + 5) % 14).toStringAsFixed(2)+"%", style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
                    ]);
                  }
                }
                )),
          )
        ],
      ),
    );
  }

  Widget topLooser() {
    return Container(
      // margin: EdgeInsets.only(right: 10.0, left: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("Top Looser", style:
            TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(228, 230, 232, 1))),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blueGrey
            ),
            child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.blueGrey),
                columns: [
                  DataColumn(
                    label: Text('SYM', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Change', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Ch%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('LTP', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    numeric: true,
                  ),
                ],
                rows: List<DataRow>.generate(
                    5, (index) {
                  if (index == 1 || index == 3 || index == 7 || index == 8 || index == 10 || index == 13 || index == 15 || index == 18 || index == 20 ||
                      index == 22 || index == 23 || index == 24 || index == 26) {
                    return DataRow(color: MaterialStateProperty.all(Colors.white), cells: [
                      DataCell(Text('Joshi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2), style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text((12 - (index + 5) % 14).toStringAsFixed(2)+"%", style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
                    ]);
                  } else {
                    return DataRow(color: MaterialStateProperty.all(Colors.white), cells: [
                      DataCell(Text('GAH', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2), style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text((12 - (index + 5) % 14).toStringAsFixed(2)+"%", style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
                      DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
                    ]);
                  }
                }
                )),
          )
        ],
      ),
    );
  }

  Widget nepseIndexWidget() {
    return Container(
      height: 240.0,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: <Widget>[
          // top stack
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(64, 178, 135, 1),
                    Color.fromRGBO(46, 128, 98, 1),
                  ],
                )
            ),
            child: Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 4.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Market Summary', style: TextStyle(color: Color.fromRGBO(227, 239, 235, 1), fontWeight: FontWeight.normal, fontSize: 14.0)),
                  Text('SM/DIMAS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14.0)),
                ],
              ),
            ),
          ),
          // bottom stack
          Positioned(
            top: 40.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(57, 60, 66, 1),
                      Color.fromRGBO(51, 55, 62, 1),
                    ],
                  )
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Balance', style: TextStyle(color: Color.fromRGBO(193, 195, 199, 1), fontWeight: FontWeight.normal, fontSize: 16.0)),
                        // IconButton(onPressed: (){}, icon: Icon(Icons.drive_file_rename_outline, color: Color.fromRGBO(193, 195, 199, 1)))
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("1,18,899.00", style:
                        TextStyle(color: Color.fromRGBO(231, 231, 231, 1), fontWeight: FontWeight.bold, fontSize: 24.0)),
                        Container(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 6.0, bottom: 6.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(35, 86, 77, 1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text("+12.18%", style: TextStyle(color: Color.fromRGBO(61, 170, 129, 1), fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 7.0),
                                child: Text('Total Turnover', style: TextStyle(fontSize: 13.0, color: Color.fromRGBO(193, 195, 199, 1))),
                              ),
                              Text('4,651,443.84', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(193, 195, 199, 1))),
                            ],
                          ),
                        )),
                        Expanded(child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 7.0),
                                child: Text('Total Traded Share', style: TextStyle(fontSize: 13.0, color: Color.fromRGBO(193, 195, 199, 1))),
                              ),
                              Text('8,636,636', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(193, 195, 199, 1))),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}