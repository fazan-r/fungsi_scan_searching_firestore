
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRcodeGenerator extends StatefulWidget {
  @override
  _QRcodeGeneratorState createState() => _QRcodeGeneratorState();
}

class _QRcodeGeneratorState extends State<QRcodeGenerator> {

  String qrData = "Empty";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            QrImage(data: qrData),
            SizedBox(height: 10.0),
            Text("Get your data/link to the QR Code"),
            TextField(controller: qrText, decoration: InputDecoration (hintText: "Enter the Data/Link"),),
            // ignore: deprecated_member_use
            SizedBox(height: 10.0),
            // ignore: deprecated_member_use
            FlatButton(
                child: Text("Generate QR Code"),
                onPressed: () async {
                  if(qrText.text.isEmpty){
                    setState(() {
                      qrData = "";
                    });
                  } else{
                    setState(() {
                      qrData = qrText.text;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.blue, width: 3.0)
                ),
            ),


          ],
        ),
      ),
    );
  }

  final qrText = TextEditingController();

}
