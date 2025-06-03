// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroVisitanteScreen extends StatefulWidget {
  @override
  _CadastroVisitanteScreenState createState() => _CadastroVisitanteScreenState();
}

class _CadastroVisitanteScreenState extends State<CadastroVisitanteScreen> {
  int? selectedQuantity;
  DateTime? selectedDate;
  String? selectedTime;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF7E5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Cadastro de Visitantes',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  title: const Text(
                    'Protocolo de visita',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.arrow_drop_down),
                  children: [
                    _bulletList([
                      'Caso venha de bicicleta, deixe-a presa ao bicicletário;',
                      'Informe ao porteiro que agendou uma visita mediada;',
                      'Faça sua visita com a companhia de um estudante de graduação das áreas da ciência;',
                      'Se houver menores de 10 anos no grupo, é preciso estar com adulto responsável;',
                      'Proibido bebidas alcoólicas e fumo na Praça da Ciência;',
                      'Proibida a entrada sem camisa ou com trajes de banho;',
                      'Animais domésticos não são permitidos;',
                      'Festas de aniversário e piqueniques são proibidos;',
                    ]),
                  ],
                ),
                const Divider(height: 32),
                _sectionTitle('Dados Pessoais'),
                _inputField('Nome', controller: _nomeController),
                _inputField(
                  'E-mail',
                  controller: _emailController,
                  validator: _validateEmail,
                ),
                _inputField(
                  'CEP',
                  controller: _cepController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _validateCep,
                ),
                _inputField(
                  'Contato',
                  controller: _contatoController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _validateContato,
                ),
                const SizedBox(height: 16),
                _sectionTitle('Quantidade de pessoas'),
                Wrap(
                  spacing: 8,
                  children: List.generate(10, (index) {
                    return ChoiceChip(
                      label: Text('${index + 1}'),
                      selected: selectedQuantity == index + 1,
                      onSelected: (selected) {
                        setState(() {
                          selectedQuantity = selected ? index + 1 : null;
                        });
                      },
                      selectedColor: Colors.orange,
                    );
                  }),
                ),
                const SizedBox(height: 24),
                _sectionTitle('Escolha uma data'),
                TableCalendar(
                  locale: 'pt_BR',
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: selectedDate ?? DateTime.now(),
                  selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.brown,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _sectionTitle('Escolha um horário'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      [
                        'Manhã - 9h',
                        'Manhã - 10h',
                        'Tarde - 14h',
                        'Tarde - 15h',
                      ].map((time) {
                        return ChoiceChip(
                          label: Text(time),
                          selected: selectedTime == time,
                          onSelected: (selected) {
                            setState(() {
                              selectedTime = selected ? time : null;
                            });
                          },
                          selectedColor: Colors.orange,
                        );
                      }).toList(),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'A Praça da Ciência é um dos Centros de Ciência, Educação e Cultura da cidade de Vitória/ES, você será muito bem-vindo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: _confirmarAgendamento,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.check, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Confirmar'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmarAgendamento() async {
    if (_formKey.currentState!.validate() &&
        selectedQuantity != null &&
        selectedDate != null &&
        selectedTime != null) {
      if (selectedDate!.isBefore(DateTime.now())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione uma data futura.')),
        );
        return;
      }

      // Verifica se o horário já está agendado para a mesma data
      final agendamentoExistente =
          await FirebaseFirestore.instance
              .collection('agendamentos')
              .where('data', isEqualTo: selectedDate!.toIso8601String())
              .where('horario', isEqualTo: selectedTime)
              .get();

      if (agendamentoExistente.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Horário indisponível para esta data.')),
        );
        return;
      }

      // Salva os dados no Firestore
      await FirebaseFirestore.instance.collection('agendamentos').add({
        'nome': _nomeController.text,
        'email': _emailController.text,
        'cep': _cepController.text,
        'contato': _contatoController.text,
        'quantidade': selectedQuantity,
        'data': selectedDate!.toIso8601String(),
        'horario': selectedTime,
        'criado_em': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Agendamento confirmado!')));

      await _enviarEmailConfirmacao();

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente')),
      );
    }
  }

  Future<void> _enviarEmailConfirmacao() async {
    final email = _emailController.text;
    final assunto = Uri.encodeComponent("Confirmação de Agendamento");
    final corpo = Uri.encodeComponent(
      "Olá!\n\nSeu agendamento foi confirmado para o dia ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} às $selectedTime.\n\nObrigado por visitar a Praça da Ciência!",
    );
    final uri = Uri.parse("mailto:$email?subject=$assunto&body=$corpo");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível enviar o e-mail.')),
      );
    }
  }

  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r"^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}");
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    if (!emailRegex.hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  String? _validateCep(String? value) {
    if (value == null || value.length != 8) return 'CEP deve ter 8 dígitos';
    return null;
  }

  String? _validateContato(String? value) {
    if (value == null || (value.length != 10 && value.length != 11)) {
      return 'Contato deve ter DDD + número (10 ou 11 dígitos)';
    }
    return null;
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.brown[700],
        ),
      ),
    );
  }

  Widget _bulletList(List<String> items) {
    return Column(
      children:
          items.map((text) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 18)),
                  Expanded(child: Text(text)),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _inputField(
    String label, {
    TextEditingController? controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
