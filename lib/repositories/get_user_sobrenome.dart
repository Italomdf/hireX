import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<String?> getDespesaDescricao() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot snapshot = await users.doc(user!.uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return data['sobrenome'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getDespesaDescricao(),
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
