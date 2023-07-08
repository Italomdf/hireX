import 'package:flutter/material.dart';

import 'package:getx/repositories/tools/rep_util.dart';
import 'package:getx/util/regex.dart';
import 'package:getx/util/tema.dart';

import 'package:getx/widgets/tools/form_imput.dart';

class FormLogin extends StatelessWidget {
  FormLogin({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

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
          const Text(
            "Login",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
          RoundedInput(
            controller: email,
            validator: userValidator,
            onChanged: (value) {},
            size: size,
            hint: 'Email',
            icone: const Icon(Icons.person),
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
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (formKey.currentState!.validate()) {
                UtilRepository().loginUser(email, senha);

                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
