import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/screens/home_screen.dart';
import 'package:qr_scanner/screens/map_page.dart';
import 'package:qr_scanner/services/scan_list_service.dart';

import 'package:qr_scanner/theme/theme.dart';

import 'services/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => ScanListService())
      ],
      child: MaterialApp(
        theme: CustomTheme.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {'home': (context) => const HomeScreen(), 'map': (context) => const MapPageScreen()},
      ),
    );
  }
}
