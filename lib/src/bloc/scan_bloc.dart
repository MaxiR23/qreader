import 'dart:async';

import 'package:qreader/src/models/scan_model.dart';
import 'package:qreader/src/providers/db_provider.dart';

class ScanBloc{
  static final ScanBloc _singleton = new ScanBloc._internal();

  factory ScanBloc(){
    return _singleton;
  }

  ScanBloc._internal(){
    getAllScans();
  }

  final _streamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get streamScan => _streamController.stream;

  dispose(){
    _streamController?.close();
  }

  getAllScans() async {
    _streamController.sink.add(await DBProvider.db.getAllScans());
  }

  addNewScan(ScanModel scan) async {
    await DBProvider.db.addScan(scan);
    getAllScans();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    getAllScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAll();
    getAllScans();
  }
}