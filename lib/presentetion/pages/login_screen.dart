import 'package:app_praca_ciencia/core/styles/styles.dart';
import 'package:app_praca_ciencia/presentetion/pages/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        decoration: BoxDecoration(color: Styles.backgroundColor),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Bem-Vindo(a),',
                  style: TextStyle(
                    fontSize: 36,
                    color: Styles.fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Image(
                  image: AssetImage('assets/images/logoLogin.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Styles.backgroundContentColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'ENTRAR',
                      style: TextStyle(
                        fontSize: 24,
                        color: Styles.fontColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildLabel('E-MAIL OU CPF'),
                    _buildTextField(),
                    _buildLabel('SENHA'),
                    _buildTextField(),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(fontSize: 15, color: Styles.fontColor),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.textFieldColor,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                      ),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                        Navigator.of(context).pushNamed('/home');
                      },
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(
                          color: Styles.fontColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 3,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Styles.lineBorderColor),
                            ),
                          ),
                        ),
                        Text('OU'),
                        Container(
                          width: 100,
                          height: 3,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Styles.lineBorderColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Entre com sua conta',
                        style: TextStyle(fontSize: 15, color: Styles.fontColor),
                      ),
                    ),

                    Row(
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
                            Navigator.of(context).pushNamed('/home');
                          },
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/images/iconGmail.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'GMAIL',
                                style: TextStyle(
                                  color: Styles.fontColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.textFieldColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                            Navigator.of(context).pushNamed('/home');
                          },
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/images/iconOutlook.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'OUTLOOK',
                                style: TextStyle(
                                  color: Styles.fontColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Não possui conta?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Styles.fontColor,
                              ),
                            ),
                            Text(
                              'Cadastre-se aqui',
                              style: TextStyle(
                                fontSize: 15,
                                color: Styles.fontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'ACESSO SEM CADASTRO',
                      style: TextStyle(
                        fontSize: 15,
                        color: Styles.fontColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLabel(String text) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 15, color: Styles.fontColor),
        textAlign: TextAlign.start,
      ),
    ),
  );
}

Widget _buildTextField() {
  return PhysicalModel(
    borderRadius: BorderRadius.circular(50),
    color: Styles.textFieldColor,
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Styles.textFieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    ),
  );
}
