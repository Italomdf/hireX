import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/repositories/avalicoes_usuario.dart';
import 'package:getx/repositories/get_users_nome.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/views/perfil.dart';
import 'package:getx/widgets/tools/card_profissionais.dart';

class HomeProfessionalBody extends StatelessWidget {
  const HomeProfessionalBody({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding,
                top: kDefaultPadding),
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Column(
              children: [
                CardProfissionais(
                  boxDecoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  corSombra: Colors.white,
                  docID: firebaseUser!.uid,
                  espec: 'Atualizar perfil',
                  image: 'assets/images/Perfil.jpg',
                  country: "Estrelas",
                  cargo: 'Engenheiro Civil',
                  press: () {
                    Get.to(() => Perfil(
                          documentId: firebaseUser.uid,
                        ));
                  },
                  price: 440,
                  title: GetUsersNome(
                    prefixo: '',
                    sufixo: '',
                    documentId: firebaseUser.uid,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                const Text(
                  'Editar  Perfil',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: kPrimaryColor, width: 3), //<-- SEE HERE
                        ),
                        onPressed: () {},
                        child: Container(
                          width: size.width / 3,
                          height: size.height * .15,
                          child: const Icon(
                            Icons.wechat_rounded,
                            color: kPrimaryColor,
                            size: 40,
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: kPrimaryColor, width: 3), //<-- SEE HERE
                        ),
                        onPressed: () {},
                        child: Container(
                          width: size.width / 3,
                          height: size.height * .15,
                          child: const Icon(
                            Icons.picture_as_pdf,
                            color: kPrimaryColor,
                            size: 40,
                          ),
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width / 2.5,
                      height: size.height * .15,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Icon(Icons.radio_button_off_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width / 2.5,
                      height: size.height * .15,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Icon(Icons.radio_button_off_outlined),
                    ),
                  ),
                ],
              ),
            ],
          ),
          CardAvaliacoes(
            contemBotao: false,
            size: size,
            idAvaliado: firebaseUser.uid,
          )
        ],
      ),
    );
  }
}
