import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/repositories/get_avaliacao_string.dart';
import 'package:getx/repositories/get_text_overflow.dart';
import 'package:getx/repositories/tools/rep_util.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/widgets/container_comentario.dart';
import 'package:getx/widgets/tools/nota_com_estrelas.dart';

import 'get_users_images.dart';

//cria lista de despesas
class ListaAvaliacoes extends StatefulWidget {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<String> docIDs;
  String idAvaliado;
  bool contemBotao; // Remove the " = true" default value

  ListaAvaliacoes({
    super.key,
    required this.idAvaliado,
    required this.docIDs,
    this.contemBotao =
        true, // Default value provided directly in the parameter declaration
    required this.formController,
  });

  @override
  State<ListaAvaliacoes> createState() => _ListaAvaliacoesState();
}

class _ListaAvaliacoesState extends State<ListaAvaliacoes> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white),
      height: size.height * 0.80,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Avaliações',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.docIDs.length,
              itemBuilder: (context, indice) {
                return ContainerComentario(
                  documentId: widget.docIDs[indice],
                  idAvaliado: widget.idAvaliado,
                );
              },
            ),
          ),
          Visibility(
            visible: widget.contemBotao,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () =>
                        UtilRepository().criaComentario(widget.idAvaliado),
                    icon: const Icon(
                      Icons.add,
                      size: 50,
                      color: kPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
