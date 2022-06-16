import 'package:flutter/material.dart';

import 'package:qr_scanner/widgets/widgets.dart';

class MapsHistoryScreen extends StatelessWidget {
  const MapsHistoryScreen({Key? key, required this.icon}) : super(key: key);

  final IconData icon;

  //Like Fragment, no Scaffold
  @override
  Widget build(BuildContext context) {
    return ListViewWidget(icon: icon);
  }
}
