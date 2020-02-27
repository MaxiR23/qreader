import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qreader/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'dbase.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' type TEXT,'
          ' value TEXT'
          ')'         
        );
      }
    );
  }

  addScanRow(ScanModel scan) async {
    final db = await database;

    final resp = await db.rawInsert(
      "INSERT INTO Scans (id, type, value) "
      "VALUES (${scan.id}, '${scan.type}', '${scan.value}')"
    );

    return resp; 
  }

  addScan(ScanModel scan) async {
    final db = await database;

    final resp = await db.insert('Scans', scan.toJson());

    return resp;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    final resp = await db.query('Scans', where:'id = ?', whereArgs:[id]);

    return resp.isNotEmpty ? ScanModel.fromJson(resp.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;

    final resp = await db.query('Scans');

    List<ScanModel> list = resp.isNotEmpty ? resp.map((f) => ScanModel.fromJson(f)).toList() : [];

    return list;
  }

  Future<List<ScanModel>> getScanByType(String type) async {
    final db = await database;

    final resp = await db.rawQuery("SELECT * FROM Scans WHERE type= '$type'");

    List<ScanModel> list = resp.isNotEmpty ? resp.map((f) => ScanModel.fromJson(f)).toList() : [];

    return list;
  }

  Future<int> updateScan(ScanModel scan) async {
    final db = await database;

    final resp = await db.update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);

    return resp;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;

    final resp = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return resp;
  }

  Future<int> deleteAll() async {
    final db = await database;

    final resp = await db.rawDelete("DELETE FROM Scans");

    return resp;
  }
}