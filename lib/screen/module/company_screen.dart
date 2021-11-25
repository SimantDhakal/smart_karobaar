import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:law_dairy/resources/api/route_manager.dart';
import 'package:law_dairy/screen/module/stocking_view_screen.dart';

class CompanyScreen extends StatefulWidget {
  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {

  List _companyData = new List();
  bool watchView, weeklySummary, dataLoad;
  TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getCompanyData();
    setState(() {
      dataLoad = false;
      watchView = true;
      weeklySummary = false;
    });
  }

  final tableSalesData = [
    new LinearSales(0, 5897899),
    new LinearSales(1, 3983939),
    new LinearSales(2, 7927383),
    new LinearSales(3, 6893839),
  ];

  _getVolumeData() {
    List<charts.Series<LinearSales, int>> series = [

      charts.Series(
        data: tableSalesData,
        id: 'Tablet',
        colorFn: (_, __) => charts.Color.fromHex(code: "#2e8062"),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
      )
    ];
    return series;
  }

  _getVolumeSellerData() {
    List<charts.Series<LinearSales, int>> series = [

      charts.Series(
        data: tableSalesData,
        id: 'Tablet',
        colorFn: (_, __) => charts.Color.fromHex(code: "#f44336"),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
      )
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkModeBg,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (watchView == false) {
                            watchView = true;
                            weeklySummary = false;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                            border: Border.all(color:  Color.fromRGBO(46, 128, 98, 1), width: 1),
                            color: watchView ? Color.fromRGBO(46, 128, 98, 1) : Color.fromRGBO(57, 60, 66, 1)
                        ),
                        child: Text("Watchlist", style:
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
                            watchView = false;
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
                        child: Text("Company", style:
                        TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // companyDetailWidget(),

            if (watchView == true)
              watchList()
            else
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: MediaQuery.of(context).padding.copyWith(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 20
                    ),
                    shrinkWrap: true,
                    itemCount: _companyData.length,
                    itemBuilder: (BuildContext context,int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StockingViewScreen(symbol: _companyData[index]['symbol'].toString())));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 3.0),
                          decoration: BoxDecoration(
                              color:  Color.fromRGBO(57, 60, 66, 1),
                              border: Border(
                                left: BorderSide(
                                  color: Colors.green,
                                  width: 5,
                                ),
                              )
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(_companyData[index]['name'], style:
                                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.grey[400])),
                                      SizedBox(height: 4.0),
                                      Text(_companyData[index]['Instrument'], style:
                                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey[500])),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(_companyData[index]['symbol'], style:
                                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.grey[400])),
                                    Text("Rs. 2829.02", style:
                                    TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.green)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),


          ],
        ),
      ),
    );
  }

  Widget watchList() {
    return Container(
      child: Column(
        children: <Widget>[
          // buying
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: AppColor.darkModeBg,
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),

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
                                      child: Text("Buying", style: TextStyle(color: Colors.grey[300], fontSize: 15.0, fontWeight: FontWeight.bold)),
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
                                decoration: BoxDecoration(
                                  // color: Colors.grey[200],
                                  color: Color.fromRGBO(57, 60, 66, 1),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                ),
                                height: 250.0,
                                child: Container(
                                  margin: EdgeInsets.all(8.0),
                                  color: Colors.white,
                                  child: Expanded(
                                    child: new charts.NumericComboChart(_getVolumeData(),
                                      animate: true,
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),

          // selling
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: AppColor.darkModeBg,
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),

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
                                        Colors.red,
                                        Colors.redAccent,
                                      ],
                                    )
                                ),
                                // padding: EdgeInsets.only(top: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                                      child: Text("Selling", style: TextStyle(color: Colors.grey[300], fontSize: 15.0, fontWeight: FontWeight.bold)),
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
                                decoration: BoxDecoration(
                                  // color: Colors.grey[200],
                                  color: Color.fromRGBO(57, 60, 66, 1),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                ),
                                height: 250.0,
                                child: Container(
                                  margin: EdgeInsets.all(8.0),
                                  color: Colors.white,
                                  child: Expanded(
                                    child: new charts.NumericComboChart(_getVolumeSellerData(),
                                      animate: true,
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget companyList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // company listView

        ],
      ),
    );
  }

  // business login
  void getCompanyData() async {
    var dio = await Dio();
    final urlCompany = APIS.base_url+APIS.securities;
    final response = await dio.get(urlCompany,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );


    final responseData = response.data;
    log(responseData.toString());
    if (responseData['success'] == true) {
      setState(() {dataLoad = false; _companyData = responseData['data'];});
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

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}