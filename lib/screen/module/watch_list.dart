import 'package:flutter/material.dart';
import 'package:law_dairy/services/subscriber_chart.dart';
import 'package:law_dairy/services/subscriber_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  var myMenuItems = <String>[
    'All',
    'Commercial Banks',
    'Hotels And Tourism',
    'Others',
    'Hydro Power',
    'Tradings',
    'Development Banks',
    'Microfinance',
    'Non Life Insurance',
    'Life Insurance',
    'Manufacturing And Processing',
    'Finance',
    'Investment',
    'Mutual Fund'
  ];

  void onSelect(item) {
    switch (item) {
      case 'Home':
        print('Home clicked');
        break;
      case 'Profile':
        print('Profile clicked');
        break;
      case 'Setting':
        print('Setting clicked');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Watchlist"),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: onSelect,
              itemBuilder: (BuildContext context) {
                return myMenuItems.map((String choice) {
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              })
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SubscriberChart(data: dataA),
              SubscriberChart(data: dataL),
            ],
          ),
        ),
      ),
    );
  }

  final List<SubscriberSeries> dataA = [
    SubscriberSeries(
      year: "CHDC",
      subscribers: 57,
      barColor: charts.ColorUtil.fromDartColor(Colors.grey),
    ),
    SubscriberSeries(
      year: "NFRA",
      subscribers: 60,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    SubscriberSeries(
      year: "TACL",
      subscribers: 170,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    SubscriberSeries(
      year: "BJL",
      subscribers: 35,
      barColor: charts.ColorUtil.fromDartColor(Colors.grey),
    ),
    SubscriberSeries(
      year: "CCLA",
      subscribers: 235,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    SubscriberSeries(
      year: "AGL",
      subscribers: 110,
      barColor: charts.ColorUtil.fromDartColor(Colors.grey),
    ),
    SubscriberSeries(
      year: "KIST",
      subscribers: 70,
      barColor: charts.ColorUtil.fromDartColor(Colors.grey),
    ),
    SubscriberSeries(
      year: "ASAL",
      subscribers: 42,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
  ];

  final List<SubscriberSeries> dataL = [
    SubscriberSeries(
      year: "CHDC",
      subscribers: 90,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    SubscriberSeries(
      year: "NFRA",
      subscribers: 40,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    SubscriberSeries(
      year: "TACL",
      subscribers: 130,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    SubscriberSeries(
      year: "BJL",
      subscribers: 55,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    SubscriberSeries(
      year: "CCLA",
      subscribers: 435,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    SubscriberSeries(
      year: "AGL",
      subscribers: 90,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    SubscriberSeries(
      year: "KIST",
      subscribers: 120,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    SubscriberSeries(
      year: "ASAL",
      subscribers: 22,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
  ];

}