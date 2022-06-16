import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/ui_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    return BottomNavigationBar(
      onTap: (value) => uiProvider.selectedMenuOpt = value,
      currentIndex: uiProvider.selectedMenuOpt,
      elevation: 8,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
              size: 30,
            ),
            label: "Map"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.compass_calibration,
              size: 30,
            ),
            label: "Directions")
      ],
    );
  }
}
