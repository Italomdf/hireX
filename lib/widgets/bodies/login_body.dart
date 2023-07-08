import 'package:flutter/material.dart';
import 'package:getx/widgets/form_login.dart';
import 'package:getx/widgets/tools/google_button.dart';
import 'package:getx/widgets/tools/header_inicio.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              HeaderInicio(
                  size: size,
                  image: const AssetImage('assets/images/Mobile_login.png'),
                  altura: size.height * 0.45),
              FormLogin(),
              GoogleButton(size: size),
            ],
          ),
        )
      ],
    );
  }
}
