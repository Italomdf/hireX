import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx/repositories/get_user_email.dart';
import 'package:getx/repositories/get_user_nome.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/views/atualiza_perfil.dart';
import 'package:getx/views/portifolio.dart';
import 'package:getx/widgets/tools/Icone_perfil.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 250,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Column(
              children: [
                IconePerfil(
                  size: size,
                  coefSize: 0.25,
                  raio: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetUserNome(
                    prefixo: '',
                    sufixo: '',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                GetUserEmail(
                  prefixo: '',
                  sufixo: '',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
        ),
        ListTile(
          title: const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: kPrimaryColor,
                ),
              ),
              Text('Perfil')
            ],
          ),
          onTap: () {
            Get.to(() => const AtualizaPerfil());
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    height: 30,
                    width: 30,
                    'assets/icons/icone_projeto.svg',
                    semanticsLabel: 'projetos',
                    colorFilter:
                        ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                  )),
              Text('Projetos')
            ],
          ),
          onTap: () {
            Get.to(() => const Portifolio());
            // Update the state of the app.
            // ...
          },
        ),
        Divider(
          color: kPrimaryColor,
        )
      ],
    );
  }
}
