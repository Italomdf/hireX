import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/repositories/tools/getters_firebase.dart';

//pega descrição das despesas no firebase
class GetUsersNome extends StatelessWidget {
  GetUsersNome(
      {super.key,
      this.style,
      required this.prefixo,
      required this.sufixo,
      this.overflow,
      required this.documentId});
  TextStyle? style;
  String? prefixo;
  String? sufixo;
  TextOverflow? overflow;
  String documentId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: GettersFirebase().getUsersNomes(documentId = documentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Text(
              '${prefixo}Usuario$sufixo',
              style: style,
              overflow: overflow,
              maxLines: 1,
            );
          } else {
            return Text(
              '$prefixo${snapshot.data}$sufixo',
              style: style,
              overflow: overflow,
              maxLines: 1,
            );
          }
        }
        return Text('Carregando...', style: style);
      },
    );
  }
}
