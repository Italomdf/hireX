import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/repositories/get_users_nome.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/util/util.dart';
import 'package:getx/views/perfil.dart';
import 'package:getx/widgets/titulo_com_botao.dart';
import 'package:getx/widgets/tools/card_profissionais.dart';

class ProfissionaisEmDestaque extends StatefulWidget {
  const ProfissionaisEmDestaque({super.key, required this.size});
  final Size size;

  @override
  State<ProfissionaisEmDestaque> createState() =>
      _ProfissionaisEmDestaqueState();
}

List<String> docIDs = [];

class _ProfissionaisEmDestaqueState extends State<ProfissionaisEmDestaque> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Util().getListaTotal(docIDs),
        builder: (context, indice) {
          return Column(
            children: [
              TituloComBotao(title: 'Profissionais em destaque', press: () {}),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                height: widget.size.height * 0.35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: docIDs.length,
                    itemBuilder: (context, indice) {
                      return Column(
                        children: [
                          CardProfissionais(
                            boxDecoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            docID: docIDs[indice],
                            espec: 'Projetos',
                            image: 'assets/images/Perfil.jpg',
                            country: "Estrelas",
                            cargo: 'Engenheiro Civil',
                            press: () {
                              Get.to(() => Perfil(
                                    documentId: docIDs[indice],
                                  ));
                            },
                            price: 440,
                            title: GetUsersNome(
                              prefixo: '',
                              sufixo: '',
                              documentId: docIDs[indice],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          );
        });
  }
}
