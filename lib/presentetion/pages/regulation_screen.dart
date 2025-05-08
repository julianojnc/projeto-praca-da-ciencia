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
                  child: _buildTitle(
                    "Bem vindo(a), aos regulamentos da Praça da Ciência",
                  ),
                ),
                _buildText(
                  "Assim como muitos espaços públicos tem seus códigos de vestimenta, regulamentos e propósito, a Praça da Ciência não é diferente, nós somos um espaço pedagógico com foco em disseminar a ciência, conheça a seguir, nossos relgulamentos e orientações para que sua visita seja bastante proveitosa.",
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: _buildTitle("Não é permitido"),
                ),
                _buildText(
                  "- Pessoas sem camisa ou traje de banho;\n- Bicicletas(use o bicicletário);\n- Menores de 10 anos, desacompanhados dos responsáveis;\n- Animais domésticos;\n- Usar patinetes, patins, skates, brinquedos motorizados ou similares;\n- Festas de aniversário, piquinique e consumo de bebidas alcoólicas;\n- Fumar.",
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: _buildTitle(
                    "Orientações para o uso dos equipamentos pedagógicos",
                  ),
                ),
                _buildText(
                  "- Leitura das placas dos equipamentos;\n- Observação quanto às restrições de uso: peso, altura e calçado adequado;\n- Seguir as orientações dos mediadores",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildText(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 20, color: Color(0xFF757575)),
  );
}

Widget _buildTitle(String title) {
  return Text(
    title,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    textAlign: TextAlign.center,
  );
}
