// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getx/repositories/lista_avaliacoes.dart';
import 'package:getx/repositories/tools/getters_firebase.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/widgets/tools/card_comentarios.dart';

class CardAvaliacoes extends StatelessWidget {
  CardAvaliacoes({
    super.key,
    required this.size,
    required this.idAvaliado,
    this.contemBotao = true,
  });

  final Size size;
  final String idAvaliado;
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<String> docIDs = [];
  bool contemBotao;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: FutureBuilder(
                  future:
                      GettersFirebase().getListaAvaliacoes(docIDs, idAvaliado),
                  builder: (context, indice) {
                    return ListaAvaliacoes(
                        contemBotao: contemBotao,
                        idAvaliado: idAvaliado,
                        docIDs: docIDs,
                        formController: formController);
                  }),
            );
          },
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: kDefaultPadding / 4),
                    child: Text(
                      'Avaliações',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.only(right: kDefaultPadding / 4),
                      height: 7,
                      color: kPrimaryColor.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ],
          ),
          CardModeloComentario(size: size),
        ],
      ),
    );
  }
}
