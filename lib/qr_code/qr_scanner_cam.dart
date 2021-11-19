
import 'package:aqs_final_project/qr_code/coba_lagi.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRcodeScan extends StatefulWidget {

  final qrcoderesult;
  const QRcodeScan({Key key, this.qrcoderesult}) : super(key: key);


  @override
  _QRcodeScanState createState() => _QRcodeScanState();
}

class _QRcodeScanState extends State<QRcodeScan> {
  final textController = TextEditingController();
  String qrcoderesult = "";

  // String qrResult = "Not yet Scanned";

  Future scan() async {
    try {
      String qrcoderesult = await BarcodeScanner.scan();
      setState(() => this.qrcoderesult = qrcoderesult);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.qrcoderesult = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.qrcoderesult = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.qrcoderesult =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.qrcoderesult = 'Unknown error: $e');
    }
  }

  // final Future<QuerySnapshot> _streambaru =
  //     FirebaseFirestore.instance.collection('transcationRecap').where('productId', isEqualTo: 'Meat').get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Scan"),
        title: TextField(
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "RESULT",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // Text(
            //   qrcoderesult,
            //   style: TextStyle(fontSize: 18.0),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: TextField(
                onChanged: (text){
                  qrcoderesult = textController.text;
                },
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'SKU',
                ),
              ),
            ),
            Container(
              width: 80,
              height: 30,
              // ignore: deprecated_member_use
              child: RaisedButton(
                child: Text('SCAN'),
                onPressed: () {
                  setState(() {
                    scan();
                    textController.text = qrcoderesult;
                  });
                },
              ),
            ),
            Container(
                height: 150,
                child: StreamBuilder<QuerySnapshot>(
                  stream: qrcoderesult != '' && qrcoderesult != null
                      ? FirebaseFirestore.instance
                          .collection('transcationRecap')
                          .where("productId", isEqualTo: qrcoderesult)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection("transcationRecap")
                          .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return new ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return new ListTile(
                              title: new Text(document['productId']),
                            );
                          }).toList(),
                        );
                    }
                  },
                )),
            // Container(
            //   height: 200,
            //   child: FutureBuilder<QuerySnapshot>(
            //       future: FirebaseFirestore.instance
            //           .collection('transcationRecap')
            //           .where('productId', isEqualTo: 'P000475')
            //           .get(),
            //       builder: (BuildContext context,
            //           AsyncSnapshot<QuerySnapshot> snapshot) {
            //         // if (snapshot.hasError) {
            //         //   return Text('Something went wrong');
            //         // }
            //         if (!snapshot.hasData) {
            //           return Center(child: Text('No data found'));
            //         }
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return Center(child: Text('Loading'));
            //         }
            //         return ListView(
            //           children:
            //           snapshot.data.docs.map((DocumentSnapshot document) {
            //             Map<String, dynamic> data = document.data();
            //             return ListTile(
            //               title: Text(data['transactionId']),
            //               subtitle: Text(data['item']),
            //             );
            //           }).toList(),
            //         );
            //       }),
            // ),

            // ignore: deprecated_member_use
            // FlatButton(
            //   padding: EdgeInsets.all(15.0),
            //   child: Text("SCAN QR CODE"),
            //   onPressed: () async {
            //     String scanning = await BarcodeScanner.scan();
            //     setState(() {
            //       qrResult = scanning;
            //     });
            //   },
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20.0),
            //     side: BorderSide(color: Colors.blue, width: 3.0),
            //   ),
            // ),
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: CobaCoba(qrcoderesult: qrcoderesult),
                  );
                },
                child: Text('Open')
            ),
          ],
        ),
      ),
    );
  }
}
