import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset("assets/images/wallpaper.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.teal,
                title: Text("Report"),
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 4,
                  tabs: [
                    Tab(text: "Daily Report"),
                    Tab(text: "Weekly Report")
                  ],
                  labelStyle: TextStyle(fontSize: 15.0),
                ),
              ),
              body: TabBarView(
                children: [
                  dailyWidget(),
                  weeklyWidget()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget dailyWidget() {
    return Expanded(
        child: Container(
          color: Colors.white,
          child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 900,
              columns: [
                DataColumn(
                  label: Text('Symbol'),
                ),
                DataColumn(
                  label: Text('LTP'),
                ),
                DataColumn(
                  label: Text('LTV'),
                ),
                DataColumn(
                  label: Text('% Change'),
                  numeric: true,
                ),
                DataColumn(
                  label: Text('Open Price'),
                  numeric: true,
                ),
                DataColumn(
                  label: Text('High Price'),
                  numeric: true,
                ),
                DataColumn(
                  label: Text('Low Price'),
                  numeric: true,
                ),
                DataColumn(
                  label: Text('Total TQ'),
                  numeric: true,
                ),
                DataColumn(
                  label: Text('Last Updated'),
                  numeric: true,
                ),
              ],
              rows: List<DataRow>.generate(
                  20,
                      (index) => DataRow(cells: [
                    DataCell(Text('GAH')),
                    DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2))),
                    DataCell(Text((7 - (index + 5) % 14).toStringAsFixed(2))),
                    DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2))),
                    DataCell(Text(((index + 0.1) * 1.4).toStringAsFixed(2))),
                    DataCell(Text(((index + 0.1) * 9.4).toStringAsFixed(2))),
                    DataCell(Text(((index + 0.1) * 18.4).toStringAsFixed(2))),
                    DataCell(Text(((index + 0.1) * 6.4).toStringAsFixed(2))),
                    DataCell(Text(((index + 0.1) * 11.4).toStringAsFixed(2))),
                  ]))),
        ),
      );
  }

  Widget weeklyWidget() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 900,
            columns: [
              DataColumn(
                label: Text('Symbol'),
              ),
              DataColumn(
                label: Text('LTP'),
              ),
              DataColumn(
                label: Text('LTV'),
              ),
              DataColumn(
                label: Text('% Change'),
                numeric: true,
              ),
              DataColumn(
                label: Text('Open Price'),
                numeric: true,
              ),
              DataColumn(
                label: Text('High Price'),
                numeric: true,
              ),
              DataColumn(
                label: Text('Low Price'),
                numeric: true,
              ),
              DataColumn(
                label: Text('Total TQ'),
                numeric: true,
              ),
              DataColumn(
                label: Text('Last Updated'),
                numeric: true,
              ),
            ],
            rows: List<DataRow>.generate(
                20,
                    (index) => DataRow(cells: [
                  DataCell(Text('GAH')),
                  DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2))),
                  DataCell(Text((7 - (index + 5) % 14).toStringAsFixed(2))),
                  DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2))),
                  DataCell(Text(((index + 0.1) * 1.4).toStringAsFixed(2))),
                  DataCell(Text(((index + 0.1) * 9.4).toStringAsFixed(2))),
                  DataCell(Text(((index + 0.1) * 18.4).toStringAsFixed(2))),
                  DataCell(Text(((index + 0.1) * 6.4).toStringAsFixed(2))),
                  DataCell(Text(((index + 0.1) * 11.4).toStringAsFixed(2))),
                ]))),
      ),
    );
  }
}
