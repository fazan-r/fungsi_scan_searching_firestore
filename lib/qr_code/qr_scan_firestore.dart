
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultForFirestore extends SearchDelegate{

  CollectionReference _firebaseFirestore =
  FirebaseFirestore.instance.collection('transcationRecap');

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: searchFieldDecorationTheme,
      textTheme: Theme.of(context).textTheme.copyWith(
        headline6: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data.docs
                .where((QueryDocumentSnapshot element) => element['productId']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text('No data found'),
              );

            } else {
              return ListView(
                children: [
                  ...snapshot.data.docs
                      .where((QueryDocumentSnapshot element) =>
                      element['productId']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot data) {

                    final String productId = data.get('productId');
                    final String item = data.get('item');

                    return ListTile(
                      onTap: () {},
                      title: Text(productId),
                      subtitle: Text(item),
                    );
                  })
                ],
              );
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Type the product ID'));
  }

}