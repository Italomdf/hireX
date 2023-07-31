import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GettersFirebase {
  Future<String?> getUserNome() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot snapshot = await users.doc(user!.uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return data['nome'] as String?;
  }

  Future<String?> getUserSobreNome() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot snapshot = await users.doc(user!.uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return data['sobrenome'] as String?;
  }

  Future<String?> getUserNomeCompleto(userid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot snapshot = await users.doc(userid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String? nome = data['nome'] as String?;
    String? sobrenome = data['sobrenome'] as String?;

    String nomeCompleto = '$nome $sobrenome';
    return nomeCompleto;
  }

  Future<String?> getUsersNomes(documentId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot snapshot = await users.doc(documentId).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return data['nome'] as String?;
  }

  //pega qualquer dado String de uma avaliação
  Future<String?> getAvaliacaoStrings(documentId, campo, idAvaliado) async {
    CollectionReference avaliacoes = FirebaseFirestore.instance
        .collection('users')
        .doc(idAvaliado)
        .collection("avaliacoes");

    DocumentSnapshot snapshot = await avaliacoes.doc(documentId).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return data['$campo'] as String?;
  }

  //pega a nota da avaliação
  Future<num?> getNotaAvaliacao(documentId, idAvaliado) async {
    CollectionReference avaliacoes = FirebaseFirestore.instance
        .collection('users')
        .doc(idAvaliado)
        .collection("avaliacoes");

    DocumentSnapshot snapshot = await avaliacoes.doc(documentId).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    num? nota = data['nota'] as num?;

    if (nota != null) {
      return num.parse(nota.toStringAsFixed(1));
    }

    return null;
  }

  Future<List<Object?>?> getListaAvaliacoes(docIDs, idAvaliado) async {
    docIDs.clear();

    var snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(idAvaliado)
        .collection("avaliacoes")
        .get();

    for (var document in snapshot.docs) {
      docIDs.add(document.reference.id);
    }

    return docIDs;
  }

  //calcula a media de notas
  Future<double?> calcularMediaNotas(userUid) async {
    CollectionReference avaliacoes = FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection("avaliacoes");

    QuerySnapshot querySnapshot = await avaliacoes.get();

    if (querySnapshot.size == 0) {
      // Se não houver documentos na subcoleção "avaliacoes", retornamos null para indicar que a média não pode ser calculada.
      return null;
    }

    double somaNotas = 0;
    int totalAvaliacoes = querySnapshot.size;

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey('nota') && data['nota'] is num) {
        somaNotas += data['nota'];
      }
    }

    double media = somaNotas / totalAvaliacoes;
    return media;
  }

  Future<int?> numeroDeAvaliacoes(userUid) async {
    CollectionReference avaliacoes = FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection("avaliacoes");

    QuerySnapshot querySnapshot = await avaliacoes.get();

    if (querySnapshot.size == 0) {
      // Se não houver documentos na subcoleção "avaliacoes", retornamos null para indicar que a média não pode ser calculada.
      return 0;
    }
    return querySnapshot.size;
  }

  /*  //fornece lista de avaliações
  Future<List<Object?>?> getListaAvaliacoes(userId) async {
    CollectionReference users = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("avaliacoes");

    QuerySnapshot querySnapshot = await users.get();

    List<Object?> lista = [];

    for (var document in querySnapshot.docs) {
      lista.add(document);
    }

    print(lista);
    return lista;
  }

  //fornece dados das avaliações recebidas conforme parametros enviados
  Future<List<String>?> pegaDadosAvaliacao(userId, campo) async {
    CollectionReference users = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("avaliacoes");

    QuerySnapshot querySnapshot = await users.get();

    List<String> lista = [];

    querySnapshot.docs.forEach((document) {
      Map<String, dynamic> documento = document.data() as Map<String, dynamic>;
      String? data = documento['$campo'] as String?;
      if (data != null) {
        lista.add(data);
      }
    });

    print(lista);
    return lista;
  }
 */
}
