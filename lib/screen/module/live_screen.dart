import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:law_dairy/components/flutter_charts/line_chart.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:law_dairy/resources/api/route_manager.dart';

class LiveScreen extends StatefulWidget {
  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {

  List _offData = new List();
  List _liveData = new List();
  bool dataLoad, sortByAsc, sortByTQ;

  @override
  void initState() {
    super.initState();
    dataLoad = false;
    sortByAsc = false;
    sortByTQ = false;
    getLiveDataSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkModeBg,
      body: Container(
        child: Column(
          children: <Widget>[
            introTitle(),
            ribbonView(),

            // header
            Container(
              padding: EdgeInsets.only(top: 14.0, bottom: 14.0, left: 5.0),
              color: Color.fromRGBO(57, 60, 66, 1),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _liveData = [];
                        _liveData = _offData;
                        if (sortByAsc == false) {
                          sortByAsc = true;
                          _liveData.sort((a, b) => a['symbol'].compareTo(b['symbol']));
                        } else {
                          sortByAsc = false;
                          _liveData.sort((a, b) => b['symbol'].compareTo(a['symbol']));
                        }
                      });
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width/7),
                      child: Text('Scrip', style: TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width/7) - 5,
                    child: Text('LTP', style: TextStyle(color: Colors.grey[400], fontSize: 15.0), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width/7) - 5,
                    child: Text('Ch %', style: TextStyle(color: Colors.grey[400], fontSize: 15.0), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width/7) -5,
                    child: Text('High', style: TextStyle(color: Colors.grey[400], fontSize: 15.0), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width/7) -5,
                    child: Text('Low', style: TextStyle(color: Colors.grey[400], fontSize: 15.0), textAlign: TextAlign.center),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width/7) + 10,
                    child: Text('LTV', style: TextStyle(color: Colors.grey[400], fontSize: 15.0), textAlign: TextAlign.center),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _liveData = [];
                        _liveData = _offData;
                        if (sortByTQ == false) {
                          print("false");
                          sortByTQ = true;
                          _liveData.sort();
                          print(_liveData);
                        } else {
                          print("true");
                          sortByTQ = false;
                          _liveData.reversed;
                        }
                      });
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width/7),
                      child: Text('TQ', style: TextStyle(color: Colors.grey[400], fontSize: 15.0), textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
            // row
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: MediaQuery.of(context).padding.copyWith(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0
                  ),
                  shrinkWrap: true,
                  itemCount: _liveData.length,
                  itemBuilder: (BuildContext context,int index) {

                    return InkWell(
                      onTap: () {
                      },
                      child: Container(
                        // margin: EdgeInsets.only(bottom: 1.0),
                        padding: EdgeInsets.only(top: 14.0, bottom: 14.0, left: 5.0),
                        decoration: BoxDecoration(
                            color:  Colors.grey[300],
                            border: Border(
                              left: BorderSide(
                                color: _liveData[index]['percentageChange'] == 0 ? Colors.grey : double.parse(_liveData[index]['percentageChange']) > 0 ? Colors.green : Colors.redAccent,
                                width: 5,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey[500],
                                width: 1,
                              ),
                            )
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: (MediaQuery.of(context).size.width/7),
                              child: Text(_liveData[index]['symbol'].toString(), style: TextStyle(color: Colors.black54, fontSize: 13.0)),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width/7) - 5,
                              child: Text(_liveData[index]['lastTradedPrice'].toString(), style: TextStyle(color: Colors.black54, fontSize: 13.0), textAlign: TextAlign.center),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width/7) - 5,
                              child: Text(_liveData[index]['percentageChange'].toString(), style: TextStyle(color: _liveData[index]['percentageChange'] == 0 ? Colors.grey : double.parse(_liveData[index]['percentageChange']) > 0 ? Colors.green : Colors.redAccent, fontSize: 13.0), textAlign: TextAlign.center),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width/7) - 5,
                              child: Text(_liveData[index]['highPrice'].toString(), style: TextStyle(color: Colors.black54, fontSize: 13.0), textAlign: TextAlign.center),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width/7) - 5,
                              child: Text(_liveData[index]['lowPrice'].toString(), style: TextStyle(color: Colors.black54, fontSize: 13.0), textAlign: TextAlign.center),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width/7) + 10,
                              child: Text(_liveData[index]['totalTradedValue'].toString(), style: TextStyle(color: Colors.black54, fontSize: 13.0), textAlign: TextAlign.center),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width/7),
                              child: Text(_liveData[index]['totalTradedQuantity'].toString(), style: TextStyle(color: Colors.black54, fontSize: 13.0), textAlign: TextAlign.center),
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

  Widget introTitle() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
      margin: EdgeInsets.only(right: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AvatarGlow(
                endRadius: 25.0,
                repeat: true,
                child: Material(     // Replace this child with your own
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10.0,
                    child: Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 7.0),
                child: Text("Live Market", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ribbonView() {
    return Container(
      margin: EdgeInsets.only(bottom: 14.0, top: 20, left: 3.0, right: 3.0),
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

  // business login
  void getLiveDataSummary() async {
    var dio = await Dio();
    final urlLogin = APIS.base_url+APIS.livedata;
    final response = await dio.get(urlLogin,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );


    final responseData = response.data;
    log(responseData.toString());
    if (responseData['success'] == true) {
      setState(() {dataLoad = false; _offData = responseData['data']; _liveData = responseData['data'];});
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

class LiveMarket {
  String first;
  String second;

  LiveMarket(this.first, this.second);
}