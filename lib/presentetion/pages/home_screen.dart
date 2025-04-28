import 'package:app_praca_ciencia/core/widgets/carrossel.dart';
import 'package:app_praca_ciencia/core/widgets/menu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Bem Vindo(a)')),
      // Menu lateral
      drawer: Menu(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          children: [
            Carrossel()
          ],
        ),
      ),
    );
  }
}
