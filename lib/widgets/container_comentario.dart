import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:getx/repositories/get_avaliacao_string.dart';
import 'package:getx/repositories/get_text_overflow.dart';
import 'package:getx/repositories/get_users_images.dart';
import 'package:getx/widgets/tools/nota_com_estrelas.dart';

class ContainerComentario extends StatelessWidget {
  ContainerComentario(
      {super.key, required this.documentId, required this.idAvaliado});
  String documentId;
  String idAvaliado;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: GetUsersImages(
                            documentId: documentId,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    GetAvaliacaoStrings(
                      idAvaliado: idAvaliado,
                      prefixo: '',
                      sufixo: '',
                      userid: documentId,
                      campo: 'nome',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                NotaComEstrelas(documentId: documentId, idAvaliado: idAvaliado)
              ],
            ),
          ),
          collapsed: Padding(
              padding: const EdgeInsets.all(10),
              child: GetComentarioOverflow(
                  idAvaliado: idAvaliado,
                  prefixo: '',
                  sufixo: '',
                  userid: documentId,
                  campo: 'comentario')),
          expanded: Padding(
              padding: const EdgeInsets.all(10),
              child: GetAvaliacaoStrings(
                  idAvaliado: idAvaliado,
                  prefixo: '',
                  sufixo: '',
                  userid: documentId,
                  campo: 'comentario')),
          theme: const ExpandableThemeData(
            tapHeaderToExpand: true,
            headerAlignment: ExpandablePanelHeaderAlignment.bottom,
            tapBodyToExpand: true,
            tapBodyToCollapse: true,
            hasIcon: false,
          ),
        ));
  }
}
