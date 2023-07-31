import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/repositories/tools/getters_firebase.dart';

//pega descrição das despesas no firebase
class GetAvaliacaoStrings extends StatelessWidget {
  GetAvaliacaoStrings(
      {super.key,
      this.style,
      required this.prefixo,
      required this.sufixo,
      required this.userid,
      required this.idAvaliado,
      required this.campo,
      this.overflow});
  TextStyle? style;
  String? prefixo;
  String? sufixo;
  TextOverflow? overflow;
  String? userid;
  String? idAvaliado;
  String? campo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: GettersFirebase().getAvaliacaoStrings(userid, campo, idAvaliado),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text(
            '$prefixo${snapshot.data}$sufixo',
            style: style,
            overflow: overflow,
          );
        }
        return Text('Carregando...', style: style);
      },
    );
  }
}
