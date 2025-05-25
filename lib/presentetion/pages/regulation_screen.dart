import 'package:app_praca_ciencia/core/styles/styles.dart';
import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:app_praca_ciencia/core/widgets/menu.dart';
import 'package:flutter/material.dart';

class RegulationScreen extends StatelessWidget {
  const RegulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Regulamentos'),
      drawer: Menu(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        decoration: BoxDecoration(color: Styles.backgroundColor),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          decoration: BoxDecoration(
            color: Styles.backgroundContentColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Styles.lineBorderColor),
                    ),
                  ),
                  child: Text(
                    'Bem vindo (a) aos regulamentos da Praça da Ciência',
                    style: TextStyle(
                      fontSize: 32,
                      color: Styles.fontColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Styles.lineBorderColor),
                    ),
                  ),
                  child: _buildText(
                    'Assim como diversos espaços públicos, a Praça da Ciência conta com códigos de vestimentas e convivência, siga nosso regulamento para uma visita bastante proveitosa.',
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: _buildTitle('Não é permitido'),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Styles.lineBorderColor),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Alinha à esquerda
                    children: [
                      _buildListItem("Pessoas sem camisa ou traje de banho;"),
                      _buildListItem("Bicicletas (use o bicicletário);"),
                      _buildListItem(
                        "Menores da 10 anos desacompanhados dos responsáveis;",
                      ),
                      _buildListItem("Animais domésticos;"),
                      _buildListItem(
                        "Usar patinetes, patins, skates, brinquedos motorizados ou similares;",
                      ),
                      _buildListItem(
                        "Festas de aniversário, piquiniques e consumo de bebidas alcoólicas;",
                      ),
                      _buildListItem("Fumar;"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: _buildTitle(
                    'Orientações para o uso dos equipamentos pedagógicos',
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Alinha à esquerda
                    children: [
                      _buildListItem("Leitura das placas dos equipamentos;"),
                      _buildListItem(
                        "Observação quanto às restrições de uso incluindo peso, altura e calçado adequado;",
                      ),
                      _buildListItem("Seguir as orientações dos mediadores."),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTitle(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 24,
      color: Styles.fontColor,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );
}

Widget _buildText(String text) {
  return Text(text, style: TextStyle(fontSize: 20, color: Styles.fontColor));
}

Widget _buildListItem(String text) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "• ",
          style: TextStyle(fontSize: 20, color: Styles.fontColor),
        ), // Marcador
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Styles.fontColor),
          ),
        ),
      ],
    ),
  );
}
