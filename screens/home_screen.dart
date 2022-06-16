import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_scanner/screens/screens.dart';
import 'package:qr_scanner/services/services.dart';

import '../services/scan_list_service.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
              onPressed: () {
                final scanListProvider = Provider.of<ScanListService>(context, listen: false);
                scanListProvider.deleteAll();
              },
              icon: const Icon(Icons.delete_outline))
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    final scanListService = Provider.of<ScanListService>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListService.loadScansByType('geo');
        return const MapsHistoryScreen(icon: Icons.map_outlined);
      case 1:
        scanListService.loadScansByType('http');

        return const DirectionsPageScreen(icon: Icons.compass_calibration);
      default:
        scanListService.loadScansByType('geo');
        return const MapsHistoryScreen(icon: Icons.compass_calibration);
    }
  }
}
