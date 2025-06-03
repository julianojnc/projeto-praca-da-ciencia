import 'package:app_praca_ciencia/core/styles/styles.dart';
// import 'package:app_praca_ciencia/core/widgets/calendar.dart';
import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showProfile = true;

  // Controllers para os campos
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          _nomeController.text = data['nome'] ?? '';
          _dataNascimentoController.text = data['dataNascimento'] ?? '';
          _cpfController.text = data['cpf'] ?? '';
          _emailController.text = data['email'] ?? '';
          _telefoneController.text = data['telefone'] ?? '';
          _enderecoController.text = data['endereco'] ?? '';
        });
      }
    }
  }

  Future<void> _saveUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'nome': _nomeController.text,
        'dataNascimento': _dataNascimentoController.text,
        'cpf': _cpfController.text,
        'email': _emailController.text,
        'telefone': _telefoneController.text,
        'endereco': _enderecoController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dados atualizados com sucesso!')),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _dataNascimentoController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

    // Função para o calendário
  // Future<void> _selectDate(BuildContext context) async {
  //   final selectedDate = await DatePicker.showCustomDatePicker(
  //     context: context,
  //   );

  //   if (selectedDate != null) {
  //     setState(() {
  //       _dataNascimentoController.text = selectedDate;
  //     });
  //   }
  // }

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
            // Navegação das abas
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
                    showProfile ? _buildProfileSection() : _buildAgendamentoSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _buildProfileSection() {
    return Column(
      children: [
        _buildTextField('Nome do Usuário', 'cadProfileIcon', controller: _nomeController),
        const SizedBox(height: 16),
        _buildTextField('Data de Nascimento', 'cadDateIcon', controller: _dataNascimentoController),
        const SizedBox(height: 16),
        _buildTextField('CPF', 'cadDocIcon', controller: _cpfController),
        const SizedBox(height: 16),
        _buildTextField('Email', 'cadEmailIcon', controller: _emailController),
        const SizedBox(height: 16),
        _buildTextField('Telefone', 'cadPhoneIcon', controller: _telefoneController),
        const SizedBox(height: 16),
        _buildTextField('Endereço', 'cadLocalIcon', controller: _enderecoController),
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
          onPressed: () {
            _saveUserData();
          },
          child: Text(
            'SALVAR',
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

  Widget _buildAgendamentoSection() {
    return Column(
      // seu código atual dos agendamentos
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
      ],
    );
  }

  Widget _buildTextField(String hintText, String iconPath, {TextEditingController? controller}) {
    return Container(
      decoration: BoxDecoration(
        color: Styles.backgroundContentColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Image(
              image: AssetImage('assets/images/$iconPath.png'),
              height: 25,
              width: 25,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
