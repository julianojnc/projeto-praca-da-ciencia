import 'package:app_praca_ciencia/core/styles/styles.dart';
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
                    'Praça da \nCiência',
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
                  child: _buildTitle('Venha nos visitar'),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Image(
                          image: AssetImage('assets/images/pointIcon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: _buildText(
                          'Av. Américo Buaiz, s/n, Enseada do Suá, Vitória - ES',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Styles.lineBorderColor),
                    ),
                  ),
                  child: Expanded(
                    child: Text(
                      'Atendimento ao público de 8h às 12h e 13h às 17h (Terça a Sexta) e 8h às  12h (Sábado e Domingo)',
                      style: TextStyle(
                        fontSize: 17,
                        color: Styles.fontColor,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.justify,
                      softWrap:
                          true, // Isso permite a quebra de linha (é true por padrão)
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: _buildTitle('Links úteis'),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/facebookIcon.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            _buildText('Praça da Ciência'),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/instagramIcon.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            _buildText('@ciencia_vix'),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image(
                                image: AssetImage('assets/images/siteIcon.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            _buildText('@ciencia_vix'),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/youtubeIcon.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            _buildText('@ciencia_vix'),
                          ],
                        ),
                      ),
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
