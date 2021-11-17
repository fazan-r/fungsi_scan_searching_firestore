
import 'package:flutter/cupertino.dart';

class DummyDataTracknTrace {

  DummyDataTracknTrace({@required this.documentIdentifier, @required this.itemName});
  final String documentIdentifier;
  final String itemName;

}

List <DummyDataTracknTrace> documentData = [
  DummyDataTracknTrace(
    documentIdentifier: 'PO-0003242',
    itemName: 'AUS FROZEN BONELESS BEEF LIVER IW HARDWICKS'
  ),
  DummyDataTracknTrace(
      documentIdentifier: 'PO-0003343',
      itemName: 'AUS FROZEN BONELESS BEEF TRIMMINGS 65 CL BP CASSINO'
  ),
  DummyDataTracknTrace(
      documentIdentifier: 'PO-0003353',
      itemName: 'FROZEN BONELESS BUFFALO RUMP (45) ALLANA'
  ),
  DummyDataTracknTrace(
      documentIdentifier: 'PO-0003378',
      itemName: 'AUS FROZEN BONELESS BEEF TRIMMINGS 65 CL BP CASSINO',
  ),
];
