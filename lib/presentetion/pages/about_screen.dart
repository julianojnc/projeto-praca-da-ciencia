import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:app_praca_ciencia/core/widgets/menu.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'A Praça'),
      drawer: Menu(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[Color(0xFFFFEA00), Color(0xFFFF6A00)],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Sobre nós",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "A Praça da Ciência oferece conhecimento e diversão em um local agradável, de frente para o mar, com segurança e amplo estacionamento, além da orientação de educadores durante toda a visita. As vias de circulação são livres, inclusive para cadeirantes.\nO acervo é composto por equipamentos interativos, expostos ao ar livre, para o estudo dos conceitos científicos ligados principalmente à física. É um local muito visitado por crianças e apreciadores da ciência.\nDurante as visitas, os participantes são convidados para um debate sobre ciência, experimentando os equipamentos e relatando suas impressões. Nessa vertente de interação entre o uso dos equipamentos científicos e o diálogo com os educadores, ocorre a popularização dos conhecimentos da ciência, tendo o lúdico como aliado importante nesse processo.\nAlém das visitas culturais (espontâneas) e mediadas (com acompanhamento), a equipe do espaço ministra oficinas científicas, palestras, atividades culturais, minicursos e programas de apoio aos profissionais da educação e público em geral.\nA Praça da Ciência também participa de pesquisas voltadas para ciência, educação e cultura.\n\nQuer conhecer a nossa história detalhada? Entre em nosso site abaixo e conheça a história da praça e de onde nós estamos localizados:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF757575),
                  ),
                  textAlign: TextAlign.justify,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Image(image: AssetImage('assets/images/logo.png')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
