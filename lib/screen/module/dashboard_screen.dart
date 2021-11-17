import 'dart:io';
import 'package:flutter/material.dart';
import 'package:law_dairy/resources/AppColor.dart';
import 'package:law_dairy/screen/module/company_screen.dart';
import 'package:law_dairy/screen/module/summarize_data_screen.dart';
import 'package:law_dairy/screen/module/training_screen.dart';
import 'package:law_dairy/screen/module/watch_list.dart';

import 'home_screen.dart';
import 'report_screen.dart';

class DashboardScreen extends StatefulWidget {

  static bool boolValue;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  // navigation drawer
  AnimationController controller;

  int currentTab = 2;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  final List<Widget> screens = [
    ReportScreen(),
    CompanyScreen(),
    HomeScreen(),
    TrainingScreen(),
    SummarizeScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();


  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 12,
          color: Color.fromRGBO(51, 55, 62, 1),
          child: Container(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            ReportScreen(); // if user taps on this Home tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.receipt,
                          size: 25,
                          color: currentTab == 0 ? Color.fromRGBO(46, 128, 98, 1) : AppColor.bottomNavigationTextNormalModebg,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Report',
                          style: TextStyle(
                            color: currentTab == 0 ? Color.fromRGBO(46, 128, 98, 1) : AppColor.bottomNavigationTextNormalModebg, fontSize: 12.0, fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            CompanyScreen(); // if user taps on this Home tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home_work,
                          size: 25,
                          color: currentTab == 1 ? Color.fromRGBO(46, 128, 98, 1) : AppColor.bottomNavigationTextNormalModebg,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Company',
                          style: TextStyle(
                            color: currentTab == 1 ? Color.fromRGBO(46, 128, 98, 1) : AppColor.bottomNavigationTextNormalModebg, fontSize: 12.0, fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            HomeScreen(); // if user taps on this Home tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            color: currentTab == 2 ? Color.fromRGBO(46, 128, 98, 1) : AppColor.bottomNavigationTextNormalModebg, fontSize: 12.0, fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        currentScreen = TrainingScreen(); // if user taps on this Home tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.library_books_sharp,
                          size: 25,
                          color: currentTab == 3 ? Color.fromRGBO(46, 128, 98, 1) : AppColor.bottomNavigationTextNormalModebg,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Training',
                          style: TextStyle(
                            color: currentTab == 3 ? Color.fromRGBO(46, 128, 98, 1) : AppColor.bottomNavigationTextNormalModebg, fontSize: 12.0, fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            SummarizeScreen(); // if user taps on this Home tab will be active
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.leaderboard,
                          size: 25,
                          color: currentTab == 4 ? Color.fromRGBO(46, 128, 98, 1) : AppColor.bottomNavigationTextNormalModebg,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Summarize',
                          style: TextStyle(
                            color: currentTab == 4 ? Color.fromRGBO(46, 128, 98, 1) : AppColor.bottomNavigationTextNormalModebg, fontSize: 12.0, fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        floatingActionButton:FloatingActionButton(
          backgroundColor: Color.fromRGBO(46, 128, 98, 1),
          elevation: 2,
          onPressed: (){
            // setState(() {
            //   currentScreen = HomeScreen(); // if user taps on this Home tab will be active
            //   currentTab = 1;
            // });
            setState(() {
              currentScreen =
                  HomeScreen(); // if user taps on this Home tab will be active
              currentTab = 2;
            });
          },
          child: Icon(Icons.home, color: Colors.white, size: 32.0), //icon inside button
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        insetPadding: EdgeInsets.all(10),
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(exit(0)),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

}