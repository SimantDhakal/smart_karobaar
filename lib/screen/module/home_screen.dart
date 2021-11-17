import 'dart:developer';
import 'package:data_table_2/data_table_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:law_dairy/components/rounded_btn/rounded_btn.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:law_dairy/resources/api/route_manager.dart';
import 'package:law_dairy/resources/api/view_storage.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dashboard_screen.dart';
import 'watch_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.darkModeBg,
        body: Container(
          padding: EdgeInsets.only(left: 7.0, right: 7.0),
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
          child: Column(
            children: <Widget>[

              // intro widget
              userInfoWidget(),

              // index widget
              nepseIndexWidget(),

              lineGraph(),


              // live data
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: <Widget>[
              //         Padding(
              //           padding: EdgeInsets.only(bottom: 10.0, top: 20.0),
              //           child: Text("Top Gainer", style:
              //           TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(228, 230, 232, 1))),
              //         ),
              //         Container(
              //           padding: EdgeInsets.all(8.0),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(20.0),
              //               color: Colors.blueGrey
              //           ),
              //           child: DataTable(
              //               headingRowColor: MaterialStateProperty.all(Colors.blueGrey),
              //               columns: [
              //                 DataColumn(
              //                   label: Text('SYM', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              //                 ),
              //                 DataColumn(
              //                   label: Text('Change', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              //                 ),
              //                 DataColumn(
              //                   label: Text('Ch%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              //                 ),
              //                 DataColumn(
              //                   label: Text('LTP', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              //                   numeric: true,
              //                 ),
              //               ],
              //               rows: List<DataRow>.generate(
              //                   5, (index) {
              //                 if (index == 1 || index == 3 || index == 7 || index == 8 || index == 10 || index == 13 || index == 15 || index == 18 || index == 20 ||
              //                     index == 22 || index == 23 || index == 24 || index == 26) {
              //                   return DataRow(color: MaterialStateProperty.all(Colors.white), cells: [
              //                     DataCell(Text('Joshi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
              //                     DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2), style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
              //                     DataCell(Text((12 - (index + 5) % 14).toStringAsFixed(2)+"%", style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
              //                     DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
              //                   ]);
              //                 } else {
              //                   return DataRow(color: MaterialStateProperty.all(Colors.white), cells: [
              //                     DataCell(Text('GAH', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
              //                     DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2), style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
              //                     DataCell(Text((12 - (index + 5) % 14).toStringAsFixed(2)+"%", style: TextStyle(color: Colors.green, fontWeight: FontWeight.normal, fontSize: 15.0))),
              //                     DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 15.0))),
              //                   ]);
              //                 }
              //               }
              //               )),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
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
              CircleAvatar(
                backgroundImage: NetworkImage('https://scontent.fktm3-1.fna.fbcdn.net/v/t1.6435-1/c174.0.1067.1067a/s160x160/240462226_1789381867939590_3188530461789134734_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=dbb9e7&_nc_ohc=oLPoOLvhe2sAX8ObZ3I&_nc_ht=scontent.fktm3-1.fna&oh=613c781a33db3424e706582051ccf9d8&oe=61A62D31'),
                backgroundColor: Colors.transparent,
                radius: 25,
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

  Widget lineGraph() {
    return Container(

    );
  }

}