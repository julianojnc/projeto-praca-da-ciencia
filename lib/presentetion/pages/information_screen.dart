import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:app_praca_ciencia/core/widgets/menu.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Informações'),
      drawer: Menu(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.7, 0.8, 0.9],
            colors: [Color(0xFFFFFFFF), Color(0xFFFFEA00), Color(0xFFFF6A00)],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 40, bottom: 20),
              child: Text(
                "Praça da Ciência",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _buildTitle(
                "Venha nos visitar:",
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.map_outlined),
                    title: _buildText(
                      "Av. Américo Buaiz, Enseada do Suá, Vitória-ES, 29.050-420",
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: _buildText(
                      "Coordenação: (27) 3345-0882",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _buildTitle(
                "Atendimento ao público:",
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  ListTile(
                    title: _buildText(
                      "Terças a Sextas: 8h às 12h e 13h às 17h",
                    ),
                  ),
                  ListTile(
                    title: _buildText(
                      "Sábados e Domingos: 8h às 12h",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20),
              child: _buildTitle(
                "Confira também:",
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.facebook),
                    title: _buildText(
                      "Praça da Ciência",
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: _buildText(
                      "@ciencia_vix",
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: _buildText(
                      "@ciencia_vix",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildText(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 16, color: Color(0xFF757575)),
  );
}

Widget _buildTitle(String title) {
  return Text(
    title,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  );
}
