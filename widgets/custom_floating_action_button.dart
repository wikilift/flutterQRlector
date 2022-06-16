import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:logger/logger.dart';

import 'package:provider/provider.dart';
import 'package:qr_scanner/helpers/helpers.dart';
import 'package:qr_scanner/models/scan_model.dart';

import '../services/scan_list_service.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () async {
          final String barcodeScanRes =
              await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancel', false, ScanMode.QR);
          //const barcodeScanRes = 'geo:45.280089,-75.922405';

          if (barcodeScanRes == '-1') return;
          final scanListService = Provider.of<ScanListService>(context, listen: false);
          final ScanModel q = await scanListService.newScan(barcodeScanRes);
          if (barcodeScanRes.contains('http')) {
            Helpers.launchUrl(barcodeScanRes);
          } else {
            Navigator.pushNamed(context, 'map', arguments: q);
          }
          //scanListService.deleteAll();
        },
        child: const Icon(Icons.filter_center_focus, color: Colors.white, size: 35));
  }
}
