import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/repositories/avalicoes_usuario.dart';
import 'package:getx/repositories/get_image_perfil.dart';
import 'package:getx/repositories/get_users_images.dart';
import 'package:getx/views/portifolio.dart';

import 'package:getx/widgets/barbearias.dart';
import 'package:getx/widgets/imagem_com_rating.dart';
import 'package:getx/widgets/info_container.dart';
import 'package:getx/widgets/titulo_com_botao.dart';

class PerfilBody extends StatelessWidget {
  PerfilBody({super.key, required this.documentId});

  final String documentId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowWithImageAndRating(
              documentId: documentId,
              size: size,
              imagem: GetUsersImages(
                documentId: documentId,
                fit: BoxFit.cover,
              ),
            ),
            InfoConatiner(size: size),
            TituloComBotao(
                title: "Portifólio",
                press: () {
                  Get.to(() => Portifolio());
                }),
            const Barbearias(),
            CardAvaliacoes(size: size, idAvaliado: documentId)
          ],
        ),
      ]),
    );
  }
}
