
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class Database {
  Future<void> createForm(Map<String, dynamic> jobData);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({ @required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createForm(Map<String, dynamic> jobData) async{
    final path = '/users/$uid/jobs/jobs_abc';
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(jobData);
  }

}