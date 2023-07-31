import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/util/regex.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/views/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Util {
  //pega dia atual
  static DateTime getEndDate() {
    return DateTime.now();
  }

  //limpa campos :)
  limpaCampos(txtData, txtDescricao, txtValor) {
    txtData.text = '';
    txtDescricao.text = '';
    txtValor.text = '';
  }

  //pega dados de TODOS os usuarios do firebase e popula lista(sem filtro de tipo)
  Future<List<String>> getListaTotal(docIDs) async {
    docIDs.clear();

    var snapshot = await FirebaseFirestore.instance.collection('users').get();

    for (var document in snapshot.docs) {
      docIDs.add(document.reference.id);
    }

    return docIDs;
  }

  //pega dados das despesas do firebase e popula lista (com filtro de tipo)
  Future<List<String>> getLista(
      tipo, docIDs, startDate, endDate, max, min) async {
    docIDs.clear();
    var firebaseUser = FirebaseAuth.instance.currentUser;

    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .collection('despesas')
        .where('tipo', isEqualTo: tipo)
        .where('data', isGreaterThanOrEqualTo: startDate)
        .where('data', isLessThanOrEqualTo: endDate)
        .get();

    for (var document in snapshot.docs) {
      var valor = document.data()['valor'];
      if (valor >= min && valor <= max) {
        docIDs.add(document.reference.id);
      }
    }

    return docIDs;
  }

  //Pega dados da despesa selecionada e preenche textfield com dados selecionados (para initial value no alterar despesa)
  pegaDadosDespesa(documentId, txtDescricao, txtValor, txtData) async {
    //pega dados da deespesa selecionada
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference despesas = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('despesas');

    DocumentSnapshot snapshot = await despesas.doc(documentId).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    //preenche textfield
    txtDescricao.text = '${data['descricao']}';
    txtValor.text = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    ).format(double.parse('${data['valor']}'));
    DateTime date = data['data'].toDate();
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    txtData.text = formattedDate;
  }

  //cadastra despesa no firebasefirestore
  cadastrofire(
      formController, txtDescricao, txtValor, txtData, auth, tipo, context) {
    if (formController.currentState!.validate() &
        txtDescricao.text.isNotEmpty &
        txtValor.text.isNotEmpty &
        txtData.text.isNotEmpty) {
      DateTime date = DateFormat('dd/MM/yyyy').parse(txtData.text);

      Timestamp timestamp = Timestamp.fromDate(date);
      String docID = auth.currentUser!.uid;
      var db = FirebaseFirestore.instance.collection('users').doc(docID);
      db.collection('despesas').add({
        'tipo': tipo,
        'valor': double.parse(txtValor.text
            .replaceAll(RegExp(r'[^\d.,]'), "")
            .replaceAll('.', '')
            .replaceAll(',', '.')),
        'descricao': txtDescricao.text,
        'data': timestamp
      });
      Navigator.pop(context);
    } else {
      const snackBar = SnackBar(
        content: Text('Por favor preencha todos os campos'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red, // Specify the behavior here
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  //seleciona foto da biblioteca do device do usuario
  Future<XFile?> pegaFoto() async {
    final ImagePicker picker = ImagePicker();
    XFile? image;
    image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  //valida email para textfield
  static String? defaultEmailValidator(String? value) {
    if (value == null || value.isEmpty || !Regex.email.hasMatch(value)) {
      return 'Email Inválido!';
    }
    return null;
  }

  //valida senha para textfield
  static String? defaultPasswordValidator(String? value) {
    if (value == null || value.isEmpty || value.length <= 2) {
      return 'A senha é muito curta!';
    }
    return null;
  }

  //confirma senha para textfield
  String? defaultConfirmationPassValidator(
      String? value, senha, senhaConfirma) {
    if (senha != senhaConfirma) {
      return 'As senhas não são iguais';
    }
    return null;
  }
}
