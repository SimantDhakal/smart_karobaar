import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:law_dairy/resources/api/route_manager.dart';

class StockingViewScreen extends StatefulWidget {

  final String symbol;

  // send data id
  StockingViewScreen({this.symbol});

  @override
  _StockingViewScreenState createState() => _StockingViewScreenState();
}

class _StockingViewScreenState extends State<StockingViewScreen> {

  StockingViewScreen stockingViewScreen;

  bool dataLoad;
  List _companyDetails = new List();

  final mobileSalesData = [
    new LinearSales(0, 10),
    new LinearSales(1, 50),
    new LinearSales(2, 200),
    new LinearSales(3, 150),
  ];

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
    dataLoad = false;
    getCompanyDetail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColor.darkModeBg,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey[300]),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: AppColor.darkModeBg,
            title: Text("SBLD806"),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 4,
              tabs: [
                Tab(text: "Summary"),
                Tab(text: "Dividend"),
                Tab(text: "Fundamental"),
              ],
              labelStyle: TextStyle(fontSize: 15.0),
            ),
          ),
          body: TabBarView(
            children: [
              Expanded(
                  child: summaryWidget()
              ),
              Expanded(
                child: dividendWidget(),
              ),
              fundamentalWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget summaryWidget() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      color: AppColor.darkModeBg,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
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
                            child: Text("Transaction Record", style: TextStyle(color: Colors.grey[300], fontSize: 15.0, fontWeight: FontWeight.bold)),
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
                  ),

                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        color: Color.fromRGBO(57, 60, 66, 1),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 7.0, bottom: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Shares Outstanding", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                                Text("8,387,823.00", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              ],
                            ),
                          ),
                          Divider(height: 2, color: AppColor.darkModeBg),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Closing Price", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                                Text("Rs. 900.00", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("80 Day Average", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                                Text("Rs. 869.30", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Day Changes", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                                Text("-0.66%", style: TextStyle(color: Colors.redAccent, fontSize: 15.0)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Shares Traded", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                                Text("11,211.00", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("52 Weeks High", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                                Text("1,412.00", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("52 Weeks Low", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                                Text("56.00", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("30 Day Average Volume", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                                Text("22,814.00", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total Market Capitalization", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                                Text("7,546,939.00", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),

                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      color: Color.fromRGBO(57, 60, 66, 1),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 7.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Total Traded Shares", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              Text("25", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                            ],
                          ),
                        ),
                        Divider(height: 2, color: AppColor.darkModeBg),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Paid up value", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              Text("Rs. 1,000", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Total Paid up Value", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              Text("Rs. 0", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("180 Days Average", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                              Text("Rs. 1,008.64", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dividendWidget() {
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
      color: AppColor.darkModeBg,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // header
            Container(
              color: Color.fromRGBO(46, 128, 98, 1),
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    width: (MediaQuery.of(context).size.width / 6) + 20,
                    child: Text("FY", style: TextStyle(fontSize: 15.0, color: Colors.grey[400])),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("Cash", style: TextStyle(fontSize: 15.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("Bonus", style: TextStyle(fontSize: 15.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("Total", style: TextStyle(fontSize: 15.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("Right", style: TextStyle(fontSize: 15.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) + 10,
                    child: Text("Dis. Date", style: TextStyle(fontSize: 15.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            // row
            Container(
              color: Color.fromRGBO(57, 60, 66, 1),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 4.0),
                    width: MediaQuery.of(context).size.width / 6 + 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("2077/78", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                        Text("2020/21", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("3.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("10", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("13.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) + 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              color: Color.fromRGBO(57, 60, 66, 1),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 4.0),
                    width: MediaQuery.of(context).size.width / 6 + 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("2076/75", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                        Text("2020/21", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("2", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("8", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("12.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) + 10,
                    child: Text("2077-09-14", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              color: Color.fromRGBO(57, 60, 66, 1),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 4.0),
                    width: MediaQuery.of(context).size.width / 6 + 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("2077/78", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                        Text("2020/21", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("3.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("10", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("13.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) + 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              color: Color.fromRGBO(57, 60, 66, 1),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 4.0),
                    width: MediaQuery.of(context).size.width / 6 + 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("2076/75", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                        Text("2020/21", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("2", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("8", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("12.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) + 10,
                    child: Text("2077-09-14", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              color: Color.fromRGBO(57, 60, 66, 1),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 4.0),
                    width: MediaQuery.of(context).size.width / 6 + 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("2077/78", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                        Text("2020/21", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("3.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("10", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("13.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) + 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              color: Color.fromRGBO(57, 60, 66, 1),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 4.0),
                    width: MediaQuery.of(context).size.width / 6 + 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("2076/75", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                        Text("2020/21", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("2", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("8", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("12.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) + 10,
                    child: Text("2077-09-14", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              color: Color.fromRGBO(57, 60, 66, 1),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 4.0),
                    width: MediaQuery.of(context).size.width / 6 + 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("2077/78", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                        Text("2020/21", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("3.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("10", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("13.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) + 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Container(
              color: Color.fromRGBO(57, 60, 66, 1),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 4.0),
                    width: MediaQuery.of(context).size.width / 6 + 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("2076/75", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                        Text("2020/21", style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("2", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("8", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("12.5", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) - 10,
                    child: Text("-", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 6) + 10,
                    child: Text("2077-09-14", style: TextStyle(fontSize: 14.0, color: Colors.grey[400]), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fundamentalWidget() {
    return Container(
      padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0),
      color: AppColor.darkModeBg,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                // color: Colors.grey[200],
                color: Color.fromRGBO(57, 60, 66, 1),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 7.0, bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("EPS (Annu)", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                        Text("18.62", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                      ],
                    ),
                  ),
                  Divider(height: 2, color: AppColor.darkModeBg),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("P/E (Annu)", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                        Text("31.00", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("P/E (Latest)", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                        Text("Rs. 38.51", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("BVPS", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                        Text("164.51", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Price/Book", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                        Text("4.36", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("PEG", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                        Text("0.20", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("RDE (%)", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                        Text("11.28", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("ROA (%)", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                        Text("2.48", style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // company detail by id
  void getCompanyDetail() async {
    var dio = await Dio();
    final urlCompany = APIS.base_url+APIS.historydata;

    var requestBody = FormData.fromMap({
      "symbol": widget.symbol
    });

    final response = await dio.post(urlCompany,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
      data: requestBody,
    );

    final responseData = response.data;
    log(responseData.toString());
    if (responseData['success'] == true) {
      setState(() {dataLoad = false; _companyDetails = responseData['data'];});
      Fluttertoast.showToast(
          msg: "Received data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {

      setState(() {
        dataLoad = false;
      });

      Fluttertoast.showToast(
          msg: responseData['message'].toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}