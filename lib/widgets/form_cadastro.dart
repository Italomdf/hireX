import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/util/regex.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/views/home.dart';
import 'package:getx/widgets/perfil_picker.dart';
import 'package:getx/widgets/tools/form_imput.dart';
import 'package:image_picker/image_picker.dart';

class FormCadastro extends StatelessWidget {
  FormCadastro({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController senhaConfirma = TextEditingController();
  final FirebaseStorage storage = FirebaseStorage.instance;
  XFile? image;

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    print('sucesso');
    return image;
  }

  Future<void> upload(String path, String ref) async {
    File file = File(path);
    try {
      await storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  String? defaultConfirmationPassValidator(
    String? value,
  ) {
    if (senha.text != senhaConfirma.text) {
      return 'As senhas não são iguais';
    }
    return null;
  }

  static String? defaultEmailValidator(String? value) {
    if (value == null || value.isEmpty || !Regex.email.hasMatch(value)) {
      return 'Email Inválido!';
    }
    return null;
  }

  static String? defaultPasswordValidator(String? value) {
    if (value == null || value.isEmpty || value.length <= 2) {
      return 'A senha é muito curta!';
    }
    return null;
  }

  Future<String?> createUser() async {
    try {
      final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: senha.text,
      );
      var firebaseUser = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser!.uid)
          .set({
        'nome': nome.text,
        'email': email.text,
        'senha': senha.text,
      });
      if (image != null) {
        String ref = 'images/user/${firebaseUser.uid}.jpg';
        await upload(image!.path, ref);
      }
      Get.to(() => const Home());
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'A senha é muito curta, deve ter no mínimo 6 caracteres.';
      } else if (e.code == 'email-already-in-use') {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Email ${email.text} já existe.',
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

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    const userValidator = defaultEmailValidator;
    const passwordValidator = defaultPasswordValidator;
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Column(
        children: [
          PerfilPicker(
            image: image,
            callback: getImage,
          ),
          const Text(
            "Cadastro",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          RoundedInput(
            controller: nome,
            validator: null,
            onChanged: (value) {},
            size: size,
            hint: 'nome',
            icone: const Icon(Icons.person),
          ),
          RoundedInput(
            controller: email,
            validator: userValidator,
            onChanged: (value) {},
            size: size,
            hint: 'Email',
            icone: const Icon(Icons.email),
          ),
          RoundedInput(
            controller: senha,
            validator: passwordValidator,
            obscure: true,
            size: size,
            hint: 'Senha',
            icone: const Icon(Icons.lock),
            onChanged: (value) {},
          ),
          RoundedInput(
            controller: senhaConfirma,
            validator: defaultConfirmationPassValidator,
            obscure: true,
            size: size,
            hint: 'Confirmar senha',
            icone: const Icon(Icons.lock),
            onChanged: (value) {},
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (formKey.currentState!.validate()) {
                createUser();

                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
