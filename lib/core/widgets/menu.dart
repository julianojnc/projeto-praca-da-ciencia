import 'package:app_praca_ciencia/core/styles/styles.dart';
import 'package:app_praca_ciencia/presentetion/pages/login_screen.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Styles.backgroundColor,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Image(image: AssetImage('assets/images/LogoMenu.png')),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Styles.backgroundContentColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                _buildOptionsMenu('Início', '/home', 'homeIcon', context),
                _buildOptionsMenu('A Praça', '/about', 'pracaIcon', context),
                _buildOptionsMenu('Mapa', '/mapa', 'mapIcon', context),
                _buildOptionsMenu('Tuor Virtual', '/tuor', 'mapIcon', context),
                _buildOptionsMenu('Oficinas', '', 'oficinasIcon', context),
                _buildOptionsMenu('Agenda', '', 'agendaIcon', context),
                _buildOptionsMenu(
                  'Regras',
                  '/regulation',
                  'regrasIcon',
                  context,
                ),
                _buildOptionsMenu(
                  'Informações',
                  '/information',
                  'infoIcon',
                  context,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.textFieldColor,
                    padding: EdgeInsets.symmetric(horizontal: 60),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  child: Text(
                    'SAIR',
                    style: TextStyle(
                      color: Styles.fontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildOptionsMenu(String text, String rota, String pathImg, context) {
  return Container(
    child: Column(
      children: [
        ListTile(
          leading: Image(
            image: AssetImage('assets/images/' + pathImg + '.png'),
            fit: BoxFit.cover,
          ),
          title: Text(
            text,
            style: TextStyle(fontSize: 20, color: Styles.fontColor),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushNamed(rota);
          },
        ),
        Divider(color: Styles.lineBorderColor),
      ],
    ),
  );
}
