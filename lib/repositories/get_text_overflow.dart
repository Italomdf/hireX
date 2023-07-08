import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class GetTextOverflow extends StatelessWidget {
  final String documentId;
  const GetTextOverflow({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference despesas = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('despesas');

    return FutureBuilder<DocumentSnapshot>(
      future: despesas.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Timestamp timestamp = data['data'];
          DateTime dateTime = timestamp.toDate();
          var formattedDate = DateFormat('E, d MMM yyyy', 'pt_BR')
              .format(dateTime); // Convert Timestamp to DateTime
          return Text(
            '{$formattedDate aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
            softWrap: true,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          );
        }
        return const Text('Carregando...');
      },
    );
  }
}
