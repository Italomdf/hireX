import 'package:flutter/material.dart';

import 'package:getx/repositories/get_user_nome.dart';
import 'package:getx/util/tema.dart';

import 'package:getx/widgets/tools/Icone_perfil.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 36 + kDefaultPadding),
            height: size.height * 0.2 - 27,
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.7,
                  child: GetUserNome(
                    overflow: TextOverflow.ellipsis,
                    prefixo: 'Olá, ',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    sufixo: '',
                  ),
                ),
                IconePerfil(
                  raio: 80,
                  size: size,
                  coefSize: 0.2,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23))
                  ]),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                    hintText: "Pesquisar",
                    hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: const Icon(Icons.search_rounded)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
