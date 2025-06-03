import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Função para tratar erros de autenticação
  String handleFirebaseAuthError(String error) {
    if (error.contains('user-not-found')) {
      return 'Usuário não encontrado.';
    } else if (error.contains('wrong-password')) {
      return 'Senha incorreta.';
    } else if (error.contains('invalid-email')) {
      return 'E-mail inválido.';
    } else {
      return 'Erro no login. Verifique suas credenciais.';
    }
  }

  // Função para login com e-mail e senha
  Future<User?> loginWithEmailPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } catch (e) {
      throw handleFirebaseAuthError(e.toString());
    }
  }

  // Função para login com Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw 'Erro no login com Google: $e';
    }
  }

  // Função para recuperação de senha
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      throw 'Erro ao enviar e-mail de recuperação: $e';
    }
  }

  // Função para acessar como visitante
  Future<User?> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      throw 'Erro ao acessar como visitante: $e';
    }
  }

  /// ✍️ Cadastro de novo usuário com e-mail e senha
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String nome,
    required String dataNascimento,
    required String cpf,
    required String telefone,
    required BuildContext context, // Para navegação e diálogos
  }) async {
    try {
      // Validação básica
      if (password.length < 8) {
        throw 'A senha deve ter pelo menos 8 caracteres';
      }

      // Cria o usuário no Firebase Auth
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      // Salva dados adicionais no Firestore
      await _saveUserData(
        uid: userCredential.user!.uid,
        email: email,
        nome: nome,
        dataNascimento: dataNascimento,
        cpf: cpf,
        telefone: telefone,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleRegisterError(e);
    } catch (e) {
      throw e.toString();
    }
  }

  /// 💾 Salva dados do usuário no Firestore
  Future<void> _saveUserData({
    required String uid,
    required String email,
    required String nome,
    required String dataNascimento,
    required String cpf,
    required String telefone,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'nome': nome.trim(),
      'email': email.trim(),
      'dataNascimento': dataNascimento.trim(),
      'cpf': cpf.trim(),
      'telefone': telefone.trim(),
      'createdAt': FieldValue.serverTimestamp(),
      'tipo': 'usuario', // Padrão para usuários comuns
    });
  }

  /// 🛡️ Tratamento de erros específicos do cadastro
  String _handleRegisterError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Este e-mail já está cadastrado.';
      case 'invalid-email':
        return 'E-mail inválido.';
      case 'operation-not-allowed':
        return 'Operação não permitida.';
      case 'weak-password':
        return 'Senha muito fraca. Use pelo menos 6 caracteres.';
      default:
        return 'Erro no cadastro: ${e.message}';
    }
  }

  /// 🔍 Verifica se CPF já está cadastrado
  Future<bool> isCpfRegistered(String cpf) async {
    final query =
        await _firestore
            .collection('users')
            .where('cpf', isEqualTo: cpf.trim())
            .limit(1)
            .get();

    return query.docs.isNotEmpty;
  }

  /// ✉️ Verifica se e-mail já está cadastrado
  Future<bool> isEmailRegistered(String email) async {
    try {
      final methods = await _auth.fetchSignInMethodsForEmail(email.trim());
      return methods.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
