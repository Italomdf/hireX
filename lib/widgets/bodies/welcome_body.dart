import 'package:flutter/material.dart';
import 'package:getx/widgets/tools/botoes_iniciais.dart';
import 'package:getx/widgets/tools/header_inicio.dart';
import 'package:getx/widgets/tools/texto_inicial.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        HeaderInicio(
          altura: size.height * 0.45,
          size: size,
          image: const AssetImage('assets/images/Construction_worker.png'),
        ),
        const TextoInicial(),
        BotoesIniciais(size: size)
      ],
    );
  }
}
