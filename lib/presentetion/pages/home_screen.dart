import 'package:app_praca_ciencia/core/widgets/carrossel.dart';
import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:app_praca_ciencia/core/widgets/menu.dart';
import 'package:app_praca_ciencia/core/widgets/oficina_section.dart';
import 'package:app_praca_ciencia/core/widgets/noticias_section.dart'; // importe seu widget notícias
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Carrossel(),
              SizedBox(height: 20), // Espaço entre carrossel e oficinas
              OficinasSection(),
              SizedBox(height: 20), // Espaço entre oficinas e notícias
              NoticiasSection(),  // Seção notícias adicionada aqui
            ],
          ),
        ),
      ),
    );
  }
}
