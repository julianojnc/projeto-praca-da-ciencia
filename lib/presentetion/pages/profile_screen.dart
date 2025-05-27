import 'package:app_praca_ciencia/core/styles/styles.dart';
import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showProfile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Perfil'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Styles.backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.account_circle,
                size: 130,
                color: Color(0xFFFFFFFF),
              ),
            ),
            // Navegacao
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton('Dados Pessoais', showProfile, () {
                  setState(() {
                    showProfile = true;
                  });
                }),
                SizedBox(width: 10),
                _buildTabButton('Agendamentos', !showProfile, () {
                  setState(() {
                    showProfile = false;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child:
                    showProfile
                        ? _buildProfileSection()
                        : _buildAgendamentoSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Abas Style
  Widget _buildTabButton(String label, bool isSelected, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Styles.button : Colors.grey[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Styles.fontColor : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // Dados do Perfil
  Widget _buildProfileSection() {
    return Column(
      children: [
        _buildTextField('Nome do Usuário', 'cadProfileIcon'),
        const SizedBox(height: 16),
        _buildTextField('Data de Nascimento', 'cadDateIcon'),
        const SizedBox(height: 16),
        _buildTextField('CPF', 'cadDocIcon'),
        const SizedBox(height: 16),
        _buildTextField('Email', 'cadEmailIcon'),
        const SizedBox(height: 16),
        _buildTextField('Telefone', 'cadPhoneIcon'),
        const SizedBox(height: 16),
        _buildTextField('Endereço', 'cadLocalIcon'),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Styles.button),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Styles.fontColor),
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            'EDITAR',
            style: TextStyle(
              color: Styles.fontColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Agendamentos
  Widget _buildAgendamentoSection() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'Oficinas',
            style: TextStyle(
              color: Styles.fontColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),

        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Styles.backgroundContentColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/images/imgOficina.png'),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
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

                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Styles.buttonSecond,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Styles.fontColor),
                              ),
                            ),
                      ),
                      onPressed: () {},
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
            ],
          ),
        ),

        SizedBox(
          width: double.infinity,
          child: Text(
            'Visitas',
            style: TextStyle(
              color: Styles.fontColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Styles.backgroundContentColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/images/imgOficina.png'),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
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

                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Styles.buttonSecond,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Styles.fontColor),
                              ),
                            ),
                      ),
                      onPressed: () {},
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
            ],
          ),
        ),

        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Styles.button),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Styles.fontColor),
              ),
            ),
          ),
          onPressed: () {},
          child: Text(
            'EDITAR',
            style: TextStyle(
              color: Styles.fontColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildTextField(String hintText, String pathImg) {
  return SizedBox(
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
                  hintStyle: TextStyle(color: Styles.fontColor, fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
