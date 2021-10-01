
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class QRcodeScan extends StatefulWidget {
  @override
  _QRcodeScanState createState() => _QRcodeScanState();
}

class _QRcodeScanState extends State<QRcodeScan> {

  String qrResult = "Not yet Scanned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("RESULT", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            Text(qrResult, style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center,),
            SizedBox(height: 20.0,),
            // ignore: deprecated_member_use
            FlatButton(
               padding: EdgeInsets.all(15.0),
               child: Text("SCAN QR CODE"),
                onPressed: ()async{
                  String scanning = await BarcodeScanner.scan();
                  setState(() {
                    qrResult = scanning;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.blue, width: 3.0),
               ) ,
             )
          ],
        ),
      ),
    );
  }


}
