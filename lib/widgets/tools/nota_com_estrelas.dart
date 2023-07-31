import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getx/repositories/get_nota_avaliacao.dart';
import 'package:getx/repositories/tools/getters_firebase.dart';

class NotaComEstrelas extends StatelessWidget {
  NotaComEstrelas(
      {super.key, required this.documentId, required this.idAvaliado});

  String documentId;
  String idAvaliado;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder<num?>(
          future: GettersFirebase().getNotaAvaliacao(documentId, idAvaliado),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return RatingBarIndicator(
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  rating: double.parse(snapshot.data!.toString()),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 25.0,
                  direction: Axis.horizontal,
                );
              } else {
                return Text('');
              }
            }
            return Text('Carregando...');
          },
        ),
        GetNotaAvaliacao(
          idAvaliado: idAvaliado,
          prefixo: '',
          sufixo: '',
          userid: documentId,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
