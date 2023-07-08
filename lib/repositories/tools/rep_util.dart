import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/util/util.dart';
import 'package:getx/views/home.dart';
import 'package:getx/views/home_professional.dart';
import 'package:image_picker/image_picker.dart';

class UtilRepository {
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseStorage storage = FirebaseStorage.instance;
  XFile? image;

  //retorna o tipo de usuario (profissional ou cliente)
  Future<String?> _verificaTipo() async {
    DocumentSnapshot snapshot = await users.doc(currentUser!.uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    data['tipo'] as String?;
    String? tipo = data['tipo'] as String?;
    return tipo;
  }

  //determina se a rota inicial será de profissional ou cliente com base no tipo de usuario
  Future<String?> determinaRotaInicial() async {
    if (currentUser == null) {
      return '/welcome';
    } else {
      String? tipo = await _verificaTipo();

      if (tipo == 'profissional') {
        return '/homeProfissional';
      } else {
        return '/home';
      }
    }
  }

  //loga o usuario
  Future<String?> loginUser(email, senha) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: senha.text,
      );

      String? tipo = await _verificaTipo();

      if (tipo == 'profissional') {
        Get.to(() => const HomeProfessional());
      } else {
        Get.to(() => const Home());
      }
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: kPrimaryColor,
          message: 'Bem vindo ${currentUser!.email}.',
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        ),
      );

      // Navigate to home page or do something else after successful login
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Usuario não encontrado para esse email.',
            icon: Icon(Icons.error),
            shouldIconPulse: true,
            duration: Duration(seconds: 3),
          ),
        );
      } else if (e.code == 'wrong-password') {
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Senha incorreta para esse usuario.',
            icon: Icon(Icons.error),
            shouldIconPulse: true,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

    return null;
  }

  Future<String?> createUser(
      String nome, String email, String senha, XFile? image) async {
    if (image != null) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: senha,
        );
        var firebaseUser = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser!.uid)
            .set({
          'nome': nome,
          'email': email,
          'senha': senha,
        });
        if (image != null) {
          String ref = 'images/user/${firebaseUser.uid}.jpg';
          await _upload(image.path, ref);
        } else {
          print('imagem vaziaaaaa');
        }
        Get.to(() => const Home());
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: kPrimaryColor,
            message: 'Bem vindo ${nome}.',
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return 'A senha é muito curta, deve ter no mínimo 6 caracteres.';
        } else if (e.code == 'email-already-in-use') {
          Get.showSnackbar(
            GetSnackBar(
              backgroundColor: Colors.red,
              message: 'Email $email já existe.',
              icon: const Icon(Icons.error),
              shouldIconPulse: true,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {}
      });
      return null;
    } else {
      print('selecione foto');
    }
  }

  //posta foto nova do usuario no storage
  Future<void> _upload(String path, String ref) async {
    File file = File(path);
    try {
      await storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  //atualiza foto do usuario
  Future<String?> atualizaFoto() async {
    image = await Util().pegaFoto();
    if (image != null) {
      String ref = 'images/user/${currentUser!.uid}.jpg';
      await _upload(image!.path, ref);
    }
    return null;
  }

  //atualzia nome do usuario
  Future<String?> atualizaNome(nome) async {
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        'nome': nome,
      });
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: kPrimaryColor,
          message: 'Bem vindo ${nome.text}.',
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  //atualzia sobrenome do usuario
  Future<String?> atualizaSobrenome(sobrenome) async {
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        'sobrenome': sobrenome,
      });
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: kPrimaryColor,
          message: 'Bem vindo ${sobrenome.text}.',
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  //atualiza dados do Usuario
  Future<String?> atualizaDados(
      String? email, String? senha, String? nome, dynamic image) async {
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .update({
        'nome': nome,
        'email': email,
        'senha': senha,
      });
      if (image != null) {
        String ref = 'images/user/${currentUser!.uid}.jpg';
        await _upload(image!.path, ref);
      }
      Get.to(() => const Home());
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: kPrimaryColor,
          message: 'Bem vindo ${nome}.',
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'A senha é muito curta, deve ter no mínimo 6 caracteres.';
      } else if (e.code == 'email-already-in-use') {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Email $email já existe.',
            icon: const Icon(Icons.error),
            shouldIconPulse: true,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {}
    });
    return null;
  }
}
