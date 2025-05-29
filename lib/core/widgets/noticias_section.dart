import 'package:flutter/material.dart';
import 'package:app_praca_ciencia/core/styles/styles.dart';

class NoticiasSection extends StatelessWidget {
  const NoticiasSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notícias',
          style: TextStyle(
            color: Styles.fontColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 10),

        // Oficina card
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Styles.backgroundContentColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Image(
                image: AssetImage('assets/images/imgOficina.png'),
                fit: BoxFit.cover,
              ),

              // Espaço ocupado pelo texto e botão
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Relógio de sol',
                          style: TextStyle(
                            color: Styles.fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '10 - 10',
                          style: TextStyle(
                            color: Styles.fontColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'MAI - MAI',
                          style: TextStyle(
                            color: Styles.fontColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Styles.buttonSecond,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Styles.fontColor),
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Ação do botão
                          },
                          child: Text(
                            'Informações',
                            style: TextStyle(
                              color: Styles.fontColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
