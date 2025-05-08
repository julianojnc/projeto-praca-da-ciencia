import 'package:app_praca_ciencia/core/widgets/carrossel.dart';
import 'package:app_praca_ciencia/core/widgets/header.dart';
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
      appBar: Header(title: 'Bem Vindo(a)'),
      drawer: Menu(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        color: Color(0xFFFFFFFF),
        child: Column(children: [Carrossel()]),
      ),
    );
  }
}
