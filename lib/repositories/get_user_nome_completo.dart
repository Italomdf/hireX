import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/repositories/tools/getters_firebase.dart';

//pega descrição das despesas no firebase
class GetUserNomeCompleto extends StatelessWidget {
  GetUserNomeCompleto(
      {super.key,
      this.style,
      required this.prefixo,
      required this.sufixo,
      required this.userid,
      this.overflow});
  TextStyle? style;
  String? prefixo;
  String? sufixo;
  TextOverflow? overflow;
  String? userid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: GettersFirebase().getUserNomeCompleto(userid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text(
            '${snapshot.data}',
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
