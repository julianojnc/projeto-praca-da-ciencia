import 'package:app_praca_ciencia/core/styles/styles.dart';
import 'package:app_praca_ciencia/presentetion/pages/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        decoration: BoxDecoration(color: Styles.backgroundColor),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFF0),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'CADASTRE-SE',
                    style: TextStyle(
                      fontSize: 36,
                      color: Styles.fontColor,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildTextField('Nome Completo', 'cadProfileIcon'),
                _buildTextField('Data de Nascimento', 'cadDateIcon'),
                _buildTextField('CPF', 'cadDocIcon'),
                _buildTextField('E-mail', 'cadEmailIcon'),
                _buildTextField('Telefone', 'cadPhoneIcon'),
                _buildTextField('Senha', 'cadPasswordIcon'),
                _buildTextField('Confirme sua senha', 'cadPasswordIcon'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'DICA DE SENHA:',
                    style: TextStyle(
                      fontSize: 15,
                      color: Styles.fontColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                _buildListItem('8 caracteres;'),
                _buildListItem('1 letra maiúscula;'),
                _buildListItem('1 letra minúscula;'),
                _buildListItem('1 número;'),
                _buildListItem('1 caractere especial;'),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Styles.textFieldColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'CANCELAR',
                          style: TextStyle(
                            color: Styles.fontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Styles.textFieldColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.of(context).pop(); // Fecha o popup
                                Navigator.of(
                                  context,
                                ).popUntil((route) => route.isFirst);
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed('/home');
                              });

                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFFFF66),
                                        Color(0xFFFF9900),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.check_circle,
                                        size: 50,
                                        color: Colors.green,
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'Usuário cadastrado com sucesso!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          'CADASTRAR',
                          style: TextStyle(
                            color: Styles.fontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
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

Widget _buildTextField(String hintText, String pathImg) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: PhysicalModel(
      borderRadius: BorderRadius.circular(50),
      color: Styles.textFieldColor,
      elevation: 2,
      shadowColor: Colors.black26,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Styles.textFieldColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage('assets/images/' + pathImg + '.png'),
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Container(width: 1, height: 30, color: Colors.grey.shade600),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Styles.fontColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildListItem(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "• ",
        style: TextStyle(fontSize: 15, color: Styles.fontColor),
      ), // Marcador
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 15, color: Styles.fontColor),
        ),
      ),
    ],
  );
}
