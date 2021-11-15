import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class SummarizeScreen extends StatefulWidget {
  @override
  _SummarizeScreenState createState() => _SummarizeScreenState();
}

class _SummarizeScreenState extends State<SummarizeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top + 20.0),
          Text("Summarize Data", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 12.0),
          dummyTable()
        ],
      ),
    );
  }

  Widget dummyTable() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: DataTable2(
            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
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

                  if (index == 3 || index == 5 || index == 9) {
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