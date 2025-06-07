import 'package:app_praca_ciencia/core/styles/styles.dart';
import 'package:app_praca_ciencia/core/widgets/carrossel.dart';
import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:app_praca_ciencia/core/widgets/menu.dart';
import 'package:app_praca_ciencia/core/widgets/oficina_section.dart';
import 'package:app_praca_ciencia/core/widgets/noticias_section.dart'; // importe seu widget notícias
import 'package:cloud_firestore/cloud_firestore.dart';
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
           children: [
              Carrossel(),
              SizedBox(height: 20), // Espaço entre carrossel e oficinas
              // Seção de Oficinas
              Text(
                'Oficinas',
                style: TextStyle(
                  color: Styles.fontColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('oficinas').snapshots(),
                builder: (context, snapshot) {
                  return OficinasSection(snapshot: snapshot);
                }
              ),
              SizedBox(height: 20), // Espaço entre oficinas e notícias
              Text(
                'Noticias',
                style: TextStyle(
                  color: Styles.fontColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('noticias').snapshots(),
                builder: (context, snapshot) {
                  return NewsSection(snapshot: snapshot);
                }
              ), // Seção notícias adicionada aqui
            ],
          ),
        ),
      ),
    );
  }
}
