import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(size: 40),
      centerTitle: true,
      title: Text(title, style: TextStyle(fontSize: 25)),
      backgroundColor: Colors.white,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Divider(height: 1.0, color: Color(0xFFFF6A00)),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            Navigator.of(context).pushNamed('/profile');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
