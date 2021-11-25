import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:law_dairy/modal/nepse_data_modal.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:law_dairy/resources/api/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List getSummaryList = new List();
  List currentList = new List();
  List timeList = new List();

  String floatValue, dayValue;
  bool change, turnover, percent, dataLoad;

  // syncfusion code
  List<_SalesData> data = [];

  @override
  void initState() {
    super.initState();
    floatValue = "Sensitive Float";
    dayValue = "1 Day";

    // init sort
    change = false;
    turnover = false;
    percent = false;
    dataLoad = false;

    if (getSummaryList.isEmpty) {
      print("Bliss");
    } else {
      print("Pliss");
    }
    getIndexSummary();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        // users.sort((a, b) => a.first.compareTo(b.first));
      } else {
        // users.sort((a, b) => a.second.compareTo(b.second));
      }
    }
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
                top: 20.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                  child: Column(
                    children: <Widget>[

                      // intro widget
                      userInfoWidget(),

                      // index widget
                      nepseIndexWidget(),

                      // chart widget
                      indexChart(),

                      // ribbon widget
                      ribbonView(),

                      // live data
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 8.0, top: 2.0, right: 8.0, bottom: 8.0),
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
                                  columnSpacing: 10.0,
                                  // sortAscending: sort,
                                  headingRowColor: MaterialStateProperty.all(Color(0xFF33373e)),
                                  columns: [
                                    DataColumn(
                                      label: Text('Index', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13.0)),
                                    ),
                                    DataColumn(
                                      label: Text('Curr', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13.0)),
                                    ),
                                    DataColumn(
                                      label: InkWell(
                                        onTap: () {
                                          setState(() {
                                            change ? change = false : change = true;
                                          });
                                        },
                                        child: Text('Chg%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13.0)),
                                      ),
                                    ),
                                    DataColumn(
                                      label: InkWell(
                                        onTap: () {
                                          setState(() {
                                            turnover ? turnover = false : turnover = true;
                                          });
                                        },
                                        child: Text('TO', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13.0)),
                                      ),
                                      numeric: true,
                                    ),
                                    DataColumn(
                                      label: InkWell(
                                        onTap: () {
                                          setState(() {
                                            percent ? percent = false : percent = true;

                                          });
                                        },
                                        child: Text('%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13.0)),
                                      ),
                                      numeric: true,
                                    ),
                                  ],
                                  rows: List<DataRow>.generate(
                                      getSummaryList.length, (index) {
                                    return DataRow(color: MaterialStateProperty.all(Colors.white), cells: [
                                      DataCell(Text(getSummaryList[index]['index_name'].toString(), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 13.0))),
                                      DataCell(Text(getSummaryList[index]['ltp'].toString(), style: TextStyle(color: double.parse(getSummaryList[index]['daily_gain'].toString()) > 0 ? Colors.green : (double.parse(getSummaryList[index]['daily_gain'].toString())) < 0 ? Colors.red : Colors.grey, fontWeight: FontWeight.normal, fontSize: 13.0))),
                                      DataCell(Text(getSummaryList[index]['daily_gain'].toString(), style: TextStyle(color: double.parse(getSummaryList[index]['daily_gain'].toString()) > 0 ? Colors.green : (double.parse(getSummaryList[index]['daily_gain'].toString())) < 0 ? Colors.red : Colors.grey, fontWeight: FontWeight.normal, fontSize: 13.0))),
                                      DataCell(Text((double.parse(getSummaryList[index]['turnover_values'].toString())/10000000).toStringAsFixed(2)+"CR", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 13.0))),
                                      DataCell(Text((100 * double.parse(getSummaryList[index]['turnover_values'].toString())/double.parse( getSummaryList.isNotEmpty ? getSummaryList[0]['turnover_values'].toString() : 0.00)).toStringAsFixed(2), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 13.0))),
                                    ]);
                                  }
                                  )),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget userInfoWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 35.0, top: 5.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text("Hello, Simant Dhakal", style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(228, 230, 232, 1))),
                    ),
                    Text("Welcome back to Smart Karobaar", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Color.fromRGBO(185, 187, 189, 1)))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://scontent.fktm3-1.fna.fbcdn.net/v/t1.6435-1/c174.0.1067.1067a/s160x160/240462226_1789381867939590_3188530461789134734_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=dbb9e7&_nc_ohc=oLPoOLvhe2sAX8ObZ3I&_nc_ht=scontent.fktm3-1.fna&oh=613c781a33db3424e706582051ccf9d8&oe=61A62D31'),
                  backgroundColor: Colors.transparent,
                  radius: 25,
                ),
              ),
            ],
          ),
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
                  Text('Tradehun Wallet', style: TextStyle(color: Color.fromRGBO(227, 239, 235, 1), fontWeight: FontWeight.normal, fontSize: 14.0)),
                  Text('BT/BIDR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14.0)),
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
                        Text('NEPSE INDEX', style: TextStyle(color: Color.fromRGBO(193, 195, 199, 1), fontWeight: FontWeight.normal, fontSize: 16.0)),
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
                        Text(getSummaryList.isNotEmpty ? getSummaryList[0]['ltp'].toString() : "", style:
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
                              Text(getSummaryList.isNotEmpty ? getSummaryList[0]['turnover_values'].toString() : "", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(193, 195, 199, 1))),
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

  Widget indexChart() {
    return Center(
      child: Container(
        height: 360,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: floatValue,
                        items: <String>['NEPSE', 'Sensitive', 'Float', 'Sensitive Float'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            floatValue = value;
                          });
                        },
                      ),
                      DropdownButton<String>(
                        value: dayValue,
                        items: <String>['1 Day', '1 Week', '1 Month', '1 Quarter', '1 Year'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dayValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                    ),
                    primaryYAxis: NumericAxis(
                        minimum: double.parse(getSummaryList[0]['sparkline']['min'].toString()) - 50.0,
                        maximum: double.parse(getSummaryList[0]['sparkline']['max'].toString()) + 50.0,
                    ),
                    trackballBehavior: TrackballBehavior(
                      lineType: TrackballLineType.vertical,
                      activationMode: ActivationMode.singleTap,
                      enable: true,
                      tooltipAlignment: ChartAlignment.near,
                      shouldAlwaysShow: false,
                      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                    ),
                    legend: Legend(isVisible: false),
                    tooltipBehavior: TooltipBehavior(enable: false),
                    series: <ChartSeries<_SalesData, String>>[
                      LineSeries<_SalesData, String>(
                          dataSource: data,
                          xValueMapper: (_SalesData sales, _) => dateTimeFormat(DateTime.parse(sales.year)),
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          dataLabelSettings: DataLabelSettings(isVisible: false),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ribbonView() {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0, top: 10.0, left: 3.0, right: 3.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
              color: Colors.green,
            ),
            padding: EdgeInsets.all(10.0),
            child: Text("Advanced: 34", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          )),

          Expanded(child: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.red,
            child: Text("Declined: 194", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          )),

          Expanded(child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              color: Colors.grey,
            ),
            child: Text("Unchanged: 16", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          )),
        ],
      ),
    );
  }

  // busiess logic
  void getIndexSummary() async {
    var dio = await Dio();
    final nepData = APIS.base_url+APIS.nepsedata;
    final response = await dio.get(nepData,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    final responseData = response.data;
    if (responseData['success'] == true) {
      setState(() {
        dataLoad = false;
        getSummaryList = responseData['data']['home_table'];
        timeList = responseData['data']['home_table'][0]['sparkline']['time'];
        currentList = responseData['data']['home_table'][0]['sparkline']['current'];

        for (int i = 0; i < currentList.length; i++) {
          data.add(new _SalesData(timeList[i].toString(), double.parse(currentList[i])));
        }
      });

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

  // datetime date formatter
  String dateTimeFormat(DateTime dataTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedTime = formatter.format(dataTime);
    return formattedTime;
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}