
import 'package:aqs_final_project/home/models/model_jobs.dart';
import 'package:aqs_final_project/services/api_path.dart';
import 'package:aqs_final_project/services/firestore_services.dart';
import 'package:flutter/foundation.dart';

abstract class Database {
  Future<void> createForm(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({ @required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;

  Future<void> createForm(Job job) => _service.setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid),
      builder: (data) => Job.fromMap(data),
  );

}

