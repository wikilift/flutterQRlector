import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider extends ChangeNotifier {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  //constructor private
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    //DBProvider.db.newScan(ScanModel(value: 'geo:22,555'));
    return _database!;
  }

  Future<Database> _initDB() async {
    //obtain path for db
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    //create path for db
    final path = join(documentDirectory.path, 'ScansDB.db');
    //create db

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute(''' 
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          type TEXT,
          value TEXT);
        )

         ''');
      },
    );
  }

  Future<int> newScanRaw(ScanModel data) async {
    final db = await database;
    return await db.rawInsert(''' INSERT INTO Scans( type, value) VALUES(
              ${data.type.toString()}, ${data.value.toString()});
      ''');
  }

  Future<int> newScan(ScanModel data) async {
    final db = await database;
    return await db.insert('Scans', data.toJson());
  }

  Future<ScanModel?> selectScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id=?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>?> selectAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>?> selectAllScansByType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type=?', whereArgs: [type]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int?> updateScan(ScanModel data) async {
    final db = await database;
    return await db.update('Scans', data.toJson(), where: 'id=?', whereArgs: [data.id]);
  }

  Future<int?> deleteScan(int id) async {
    final db = await database;
    return await db.delete('Scans', where: 'id=?', whereArgs: [id]);
  }

  Future<int?> deleteAllScan() async {
    final db = await database;
    return await db.delete('Scans');
  }
}
