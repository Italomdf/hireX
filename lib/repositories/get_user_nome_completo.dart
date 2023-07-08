import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//pega descrição das despesas no firebase
class GetUserNomeCompleto extends StatelessWidget {
  GetUserNomeCompleto(
      {super.key,
      this.style,
      required this.prefixo,
      required this.sufixo,
      this.overflow});
  TextStyle? style;
  String? prefixo;
  String? sufixo;
  TextOverflow? overflow;

  Future<Map<String, String?>> getDespesaDescricao() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot snapshot = await users.doc(user!.uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String? nome = data['nome'] as String?;
    String? sobrenome = data['sobrenome'] as String?;

    return {
      'nome': nome,
      'sobrenome': sobrenome,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: getDespesaDescricao(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String? nome = snapshot.data?['nome'];
          String? sobrenome = snapshot.data?['sobrenome'];

          return Text(
            '$prefixo$nome $sobrenome$sufixo',
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
