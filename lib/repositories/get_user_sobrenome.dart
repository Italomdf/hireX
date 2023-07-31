import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/repositories/tools/getters_firebase.dart';

//pega descrição das despesas no firebase
class GetUserSobrenome extends StatelessWidget {
  GetUserSobrenome(
      {super.key,
      this.style,
      required this.prefixo,
      required this.sufixo,
      this.overflow});
  TextStyle? style;
  String? prefixo;
  String? sufixo;
  TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: GettersFirebase().getUserSobreNome(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text(
            '$prefixo${snapshot.data}$sufixo',
            style: style,
            overflow: overflow,
            maxLines: 1,
          );
        }
        return Text('Carregando...', style: style);
      },
    );
  }
}
