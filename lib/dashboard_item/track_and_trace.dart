

import 'package:aqs_final_project/dashboard_item/dummytrackntrace/dummydata_trackntrace.dart';
import 'package:flutter/material.dart';


class TracknTrace extends StatefulWidget {
  @override
  _TracknTraceState createState() => _TracknTraceState();
}

class _TracknTraceState extends State<TracknTrace> {

  int dataLength;
  List<DummyDataTracknTrace> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track and Trace'),),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Container(
              child: TextFormField(
                onChanged: (value){
                  setState(() {
                    dataLength = documentData.where((element) => element.documentIdentifier.toLowerCase().startsWith(value)).length;
                    data = documentData.where((element) => element.documentIdentifier.toLowerCase().startsWith(value)).toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter Document ID',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

          ...List.generate(dataLength == null ? documentData.length : dataLength, (index) {

            final daftardata = data == null? documentData[index] : data[index];

            return ListTile(
              title: Text(daftardata.documentIdentifier),
              subtitle: Text(daftardata.itemName),

            );
          }),

          ],
        ),
      ),
    );
  }
}
