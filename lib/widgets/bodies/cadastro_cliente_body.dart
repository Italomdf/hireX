import 'package:flutter/material.dart';

import 'package:getx/widgets/form_cadastro.dart';

import 'package:getx/widgets/tools/google_button.dart';
import 'package:getx/widgets/tools/header_inicio.dart';

class CadastroClienteBody extends StatelessWidget {
  const CadastroClienteBody({
    super.key,
  });

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
                  image: const AssetImage('assets/images/Online_review-.png'),
                  altura: size.height * 0.3),
              FormCadastro(),
              GoogleButton(size: size),
            ],
          ),
        )
      ],
    );
  }
}
