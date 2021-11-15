import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatefulWidget {
  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
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
                title: Text("Company"),
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 4,
                  tabs: [
                    Tab(text: "Company Detail"),
                    Tab(text: "Stock Screening")
                  ],
                  labelStyle: TextStyle(fontSize: 15.0),
                ),
              ),
              body: TabBarView(
                children: [
                  companyDetailWidget(),
                  stockScreeningWidget()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget companyDetailWidget() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 12.0),
          Text("Divided History", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 12.0),
          dummyTable(),

          SizedBox(height: 25.0),
          Text("Fibo Cal After Click", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 12.0),
          dummyTable()
        ],
      ),
    );
  }

  Widget stockScreeningWidget() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Key Ratio Sorting", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
              Container(
                padding: EdgeInsets.only(left: 14.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Row(
                  children: <Widget>[
                    Text("Filter"),
                    IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt_outlined, color: Colors.black54,)),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 12.0),
          dummyTable(),
        ],
      ),
    );
  }

  Widget dummyTable() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: DataTable2(
            headingRowColor: MaterialStateProperty.all(Colors.grey[300]),
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
                10,
                    (index) {

                  if (index == 3 || index == 5 || index == 7) {
                    return DataRow(color: MaterialStateProperty.all(Colors.green), cells: [
                      DataCell(Text('GAH')),
                      DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2))),
                      DataCell(Text((7 - (index + 5) % 14).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 1.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 9.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 18.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 6.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 11.4).toStringAsFixed(2))),
                    ]);
                  } else {
                    return DataRow(color: MaterialStateProperty.all(Colors.red), cells: [
                      DataCell(Text('GAH')),
                      DataCell(Text((15 - (index + 5) % 10).toStringAsFixed(2))),
                      DataCell(Text((7 - (index + 5) % 14).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 15.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 1.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 9.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 18.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 6.4).toStringAsFixed(2))),
                      DataCell(Text(((index + 0.1) * 11.4).toStringAsFixed(2))),
                    ]);
                  }
                }
            )),
      ),
    );
  }

}