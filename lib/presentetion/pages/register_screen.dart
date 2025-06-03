import 'package:app_praca_ciencia/core/services/auth_service.dart';
import 'package:app_praca_ciencia/core/styles/styles.dart';
import 'package:app_praca_ciencia/core/widgets/calendar.dart';
import 'package:app_praca_ciencia/presentetion/pages/login_screen.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  // Mascara para cpf
  final _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // Mascara para telefone
  final _telefoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // Mascara para Data de nascimento
  final _dataNascimentoFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // Função para cadastrar um novo usuário
  Future<void> _registerUser() async {
    setState(() => _isLoading = true);
    try {
      // Validações básicas
      if (_senhaController.text != _confirmarSenhaController.text) {
        throw 'As senhas não coincidem';
      }

      // Validação da data de nascimento
      if (_dataNascimentoController.text.length != 10) {
        throw 'Data de nascimento inválida';
      }

      // Validação do CPF
      if (_cpfController.text.length != 14) {
        throw 'CPF inválido';
      }

      // Validação do telefone
      if (_telefoneController.text.length < 14) {
        // (XX) XXXX-XXXX ou (XX) XXXXX-XXXX
        throw 'Telefone inválido';
      }

      // Executa o cadastro
      await _authService.registerWithEmailAndPassword(
        email: _emailController.text,
        password: _senhaController.text,
        nome: _nomeController.text,
        dataNascimento: _dataNascimentoController.text,
        cpf: _cpfController.text,
        telefone: _telefoneController.text,
        context: context,
      );

      // Mostra o Dialog de sucesso
      _showSuccessDialog();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Função para mostrar o Dialog com a mensagem de sucesso após cadastrado
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Depois de 2 segundos é enviado para a tela Home
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/home');
        });

        // Dialog content
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFFF66), Color(0xFFFF9900)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check_circle, size: 50, color: Colors.green),
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
  }

  // Função para o calendário
  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await DatePicker.showCustomDatePicker(
      context: context,
    );

    if (selectedDate != null) {
      setState(() {
        _dataNascimentoController.text = selectedDate;
      });
    }
  }

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
                // Input Nome Completo
                _buildTextField(
                  'Nome Completo',
                  'cadProfileIcon',
                  _nomeController,
                ),
                // Input Data de Nascimento
                _buildTextField(
                  'Data de Nascimento',
                  'cadDateIcon',
                  _dataNascimentoController,
                  isDateField: true,
                  formatter: _dataNascimentoFormatter,
                ),
                // Input de CPF
                _buildTextField(
                  'CPF',
                  'cadDocIcon',
                  _cpfController,
                  formatter: _cpfFormatter,
                ),
                // Input de Email
                _buildTextField('E-mail', 'cadEmailIcon', _emailController),
                _buildTextField(
                  'Telefone',
                  'cadPhoneIcon',
                  _telefoneController,
                  formatter: _telefoneFormatter,
                ),
                // Input de Senha
                _buildTextField(
                  'Senha',
                  'cadPasswordIcon',
                  _senhaController,
                  isPassword: true,
                ),
                // Input de Confirmar Senha
                _buildTextField(
                  'Confirme sua senha',
                  'cadPasswordIcon',
                  _confirmarSenhaController,
                  isPassword: true,
                ),

                // Dicas referente a senha
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
                // Lista de dicas
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
                        onPressed: _isLoading ? null : _registerUser,
                        // Enquanto carrega o registro do usuário o nome do botão é alterado
                        child: Text(
                          _isLoading ? 'AGUARDE...' : 'CADASTRAR',
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

  // build de input com seu style padrão
  Widget _buildTextField(
    String hintText,
    String pathImg,
    TextEditingController controller, {
    // Validação se o input é referente a senha
    bool isPassword = false,
    // Validação se o input é referente a data
    bool isDateField = false,
    // Validação se o input contém mascara
    TextInputFormatter? formatter,
  }) {
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
                image: AssetImage('assets/images/${pathImg}.png'),
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Container(width: 1, height: 30, color: Colors.grey.shade600),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isPassword,
                  inputFormatters: formatter != null ? [formatter] : null,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: Styles.fontColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    suffixIcon:
                        isDateField
                            ? IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Styles.fontColor,
                              ),
                              onPressed: () => _selectDate(context),
                            )
                            : null,
                  ),
                  readOnly: isDateField,
                  onTap:
                      isDateField
                          ? () async => await _selectDate(context)
                          : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// build de lista com seu style padrão
Widget _buildListItem(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("• ", style: TextStyle(fontSize: 15, color: Styles.fontColor)),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 15, color: Styles.fontColor),
        ),
      ),
    ],
  );
}
