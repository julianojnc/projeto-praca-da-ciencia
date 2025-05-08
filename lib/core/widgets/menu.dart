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
      backgroundColor: Color(0xFFFFFFFF),
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Image(image: AssetImage('assets/images/LogoMenu.png')),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.of(context).pushNamed('/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: Text('Mapa'),
            onTap: () {
              Navigator.of(context).pushNamed('/mapa');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text('Informações'),
            onTap: () {
              Navigator.of(context).pushNamed('/information');
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: Text('Tuor Virtual'),
            onTap: () {
              Navigator.of(context).pushNamed('');
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: Text('Agendamentos'),
            onTap: () {
              Navigator.of(context).pushNamed('');
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: Text('Notícias'),
            onTap: () {
              Navigator.of(context).pushNamed('');
            },
          ),
          ListTile(
            leading: const Icon(Icons.park),
            title: Text('A Praça'),
            onTap: () {
              Navigator.of(context).pushNamed('/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.rule),
            title: Text('Regulamentos'),
            onTap: () {
              Navigator.of(context).pushNamed('/regulation');
            },
          ),
        ],
      ),
    );
  }
}