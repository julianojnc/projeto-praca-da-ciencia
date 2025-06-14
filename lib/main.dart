import 'package:app_praca_ciencia/presentetion/pages/about_screen.dart';
import 'package:app_praca_ciencia/presentetion/pages/home_screen.dart';
import 'package:app_praca_ciencia/presentetion/pages/information_screen.dart';
import 'package:app_praca_ciencia/presentetion/pages/map_screen.dart';
import 'package:app_praca_ciencia/presentetion/pages/profile_screen.dart';
import 'package:app_praca_ciencia/presentetion/pages/register_screen.dart';
import 'package:app_praca_ciencia/presentetion/pages/regulation_screen.dart';
import 'package:app_praca_ciencia/presentetion/pages/splash_screen.dart';
import 'package:app_praca_ciencia/presentetion/pages/tour_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => SplashScreen(),
        '/home': (_) => HomeScreen(),
        '/mapa': (_) => MapScreen(),
        '/information': (_) => InformationScreen(),
        '/tuor': (_) => TuorScreen(),
        '/about': (_) => AboutScreen(),
        '/regulation': (_) => RegulationScreen(),
        '/profile': (_) => ProfileScreen(),
        '/register': (_) => RegisterScreen(),
      },
    );
  }
}
