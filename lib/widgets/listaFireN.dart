import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/repositories/get_despesa_descricao.dart';
import 'package:getx/repositories/get_despesa_time.dart';
import 'package:getx/repositories/get_text_overflow.dart';

//cria lista de despesas
class ListaFireN extends StatefulWidget {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<String> docIDs;

  ListaFireN({Key? key, required this.docIDs, required this.formController})
      : super(key: key);

  @override
  State<ListaFireN> createState() => _ListaFireNState();
}

class _ListaFireNState extends State<ListaFireN> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                  'Comentários',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: widget.docIDs.length,
                itemBuilder: (context, indice) {
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
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    'https://source.unsplash.com/50x50/?portrait',
                                  ),
                                ),
                              ),
                              GetDespesaDescricao(
                                  documentId: widget.docIDs[indice]),
                            ],
                          ),
                        ),
                        collapsed: Padding(
                            padding: const EdgeInsets.all(10),
                            child: GetTextOverflow(
                                documentId: widget.docIDs[indice])),
                        expanded: Padding(
                            padding: const EdgeInsets.all(10),
                            child: GetDespesasTime(
                                documentId: widget.docIDs[indice])),
                        theme: const ExpandableThemeData(
                          tapHeaderToExpand: true,
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.bottom,
                          tapBodyToExpand: true,
                          tapBodyToCollapse: true,
                          hasIcon: false,
                        ),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
