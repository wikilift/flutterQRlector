import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/scan_list_service.dart';
import '../widgets/list_view_widget.dart';

class DirectionsPageScreen extends StatelessWidget {
  const DirectionsPageScreen({Key? key, required this.icon}) : super(key: key);

  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListViewWidget(icon: icon);
  }
}
