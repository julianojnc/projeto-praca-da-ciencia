import 'package:app_praca_ciencia/core/widgets/header.dart';
import 'package:app_praca_ciencia/core/widgets/menu.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Perfil'),
      drawer: Menu(),
      body: Container(
        color: const Color(0xFFFFFFFF),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 60),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[Color(0xFFFFEA00), Color(0xFFFF6A00)],
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: const Icon(
                  Icons.account_circle,
                  size: 130,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              // Form Section
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 25,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to left
                  children: [
                    _buildLabel('Nome Completo'),
                    _buildTextField('Nome do Usuário'),

                    const SizedBox(height: 16),
                    _buildLabel('CPF'),
                    _buildTextField('CPF do Usuário'),

                    const SizedBox(height: 16),
                    _buildLabel('Endereço'),
                    _buildTextField('Endereço do Usuário'),

                    const SizedBox(height: 16),
                    _buildLabel('Bairro'),
                    _buildTextField('Bairro do Usuário'),

                    const SizedBox(height: 16),
                    _buildLabel('Data de nascimento'),
                    _buildTextField('Data de nascimento do Usuário'),

                    const SizedBox(height: 16),
                    _buildLabel('Telefone'),
                    _buildTextField('Telefone do Usuário'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF424242),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(25),
      color: Color(0xFFFFFFFF),
      elevation: 5.0,
      shadowColor: Color(0xFFF5F5F5),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
        style: const TextStyle(color: Color(0x00000000)),
      ),
    );
  }
}
