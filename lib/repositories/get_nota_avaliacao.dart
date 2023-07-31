import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/repositories/tools/getters_firebase.dart';

//pega descrição das despesas no firebase
class GetNotaAvaliacao extends StatelessWidget {
  GetNotaAvaliacao(
      {super.key,
      this.style,
      required this.prefixo,
      required this.sufixo,
      required this.userid,
      required this.idAvaliado,
      this.overflow});
  TextStyle? style;
  String? prefixo;
  String? sufixo;
  TextOverflow? overflow;
  String? userid;
  String? idAvaliado;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<num?>(
      future: GettersFirebase().getNotaAvaliacao(userid, idAvaliado),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Text(
              '$prefixo${snapshot.data}$sufixo',
              style: style,
              overflow: overflow,
            );
          } else {
            return Text('Sem Avaliação');
          }
        }
        return Text('Carregando...', style: style);
      },
    );
  }
}
