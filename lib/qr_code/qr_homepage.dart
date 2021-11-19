import 'package:aqs_final_project/qr_code/coba_lagi.dart';
import 'package:aqs_final_project/qr_code/qr_generator.dart';
import 'package:aqs_final_project/qr_code/qr_scanner_cam.dart';
// import 'package:aqs_final_project/qr_code/qr_scanner_cam.dart';
import 'package:flutter/material.dart';

class QrcodeHomePage extends StatefulWidget {
  @override
  _QrcodeHomePageState createState() => _QrcodeHomePageState();
}

class _QrcodeHomePageState extends State<QrcodeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Button("Scan QR CODE", QRcodeScan()),
            SizedBox(height: 10.0,),
            Button("Generate QR CODE", QRcodeGenerator()),
          ],
        ),
      ),

    );
  }
  
  // ignore: non_constant_identifier_names
  Widget Button (String text, Widget widget){
    // ignore: deprecated_member_use
    return FlatButton(
        padding: EdgeInsets.all(15.0),
        child: Text(text),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> widget));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.blue, width: 3.0),
        ) ,
    );
  }
  
  
}
