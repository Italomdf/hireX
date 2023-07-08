// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:getx/repositories/get_user_nome.dart';
import 'package:getx/repositories/get_user_sobrenome.dart';
import 'package:getx/repositories/tools/rep_util.dart';
import 'package:getx/util/tema.dart';

import 'package:getx/widgets/tools/Icone_perfil.dart';
import 'package:getx/widgets/tools/botao_atualizar.dart';
import 'package:getx/widgets/tools/wave_cilpper.dart';

import 'package:image_picker/image_picker.dart';

class FormAtualiza extends StatelessWidget {
  FormAtualiza({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController sobrenome = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController senhaConfirma = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: kPrimaryColor,
                          height: size.height * 0.4,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        color: kPrimaryColor,
                        height: (size.height * 0.4) - 20,
                        width: size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  IconePerfil(
                                    size: size,
                                    coefSize: 0.4,
                                    raio: 100,
                                  ),
                                  const Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Perfil",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
              ),
            ],
          ),
        ),
        BotaoAtualizarDado(
          hint: 'Nome',
          onUpdatePressed: () => UtilRepository().atualizaNome(nome.text),
          controller: nome,
          texto: GetUserNome(
            overflow: TextOverflow.ellipsis,
            prefixo: '',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.grey.shade600,
                ),
            sufixo: '',
          ),
          icone: Icons.person,
        ),
        BotaoAtualizarDado(
          hint: 'Sobrenome',
          onUpdatePressed: () =>
              UtilRepository().atualizaSobrenome(sobrenome.text),
          controller: sobrenome,
          texto: GetUserSobrenome(
            overflow: TextOverflow.ellipsis,
            prefixo: '',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.grey.shade600,
                ),
            sufixo: '',
          ),
          icone: Icons.person,
        ),
        TextButton(onPressed: () {}, child: const Text('Esqueci a senha'))
      ],
    );
  }
}
