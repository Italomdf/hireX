import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/widgets/barbearias.dart';
import 'package:getx/widgets/header_with_searchbox.dart';
import 'package:getx/widgets/profissionais_em_destaque.dart';
import 'package:getx/widgets/titulo_com_botao.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> docIDs = [];
    var firebaseUser = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderWithSearchBox(size: size),
          ProfissionaisEmDestaque(size: size),
          TituloComBotao(title: "Portifólios em destaque", press: () {}),
          const Barbearias(),
          const SizedBox(
            height: kDefaultPadding,
          )
        ],
      ),
    );
  }
}
