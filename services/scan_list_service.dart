import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/services/services.dart';

class ScanListService extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;
    if (selectedType == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.selectAllScans();
    this.scans = [...scans!];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.selectAllScansByType(type);
    this.scans = [...scans!];
    selectedType = type;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  deleteOne(int id) async {
    await DBProvider.db.deleteScan(id);
    loadScansByType(selectedType);
  }
}
