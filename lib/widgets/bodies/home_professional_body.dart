import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/widgets/barbearias.dart';
import 'package:getx/widgets/header_with_searchbox.dart';
import 'package:getx/widgets/profissionais_em_destaque.dart';
import 'package:getx/widgets/titulo_com_botao.dart';

class HomeProfessionalBody extends StatelessWidget {
  HomeProfessionalBody({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderWithSearchBox(size: size),
        ],
      ),
    );
  }
}
