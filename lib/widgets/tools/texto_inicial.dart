import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';

class TextoInicial extends StatelessWidget {
  const TextoInicial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Bem Vindo ao HireX",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Escolha uma opção abaixo",
          ),
        ),
      ],
    );
  }
}
