import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/views/atualiza_perfil.dart';
import 'package:getx/views/welcome_page.dart';
import 'package:getx/widgets/bodies/body.dart';
import 'package:getx/widgets/my_bottom_navBar.dart';

//homepage contendo tabBar com outras telas
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //faz logout
  _signOut() async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: ((context) => const WelcomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: const SafeArea(child: Body()),
        appBar: buildAppBar(),
        bottomNavigationBar: const MyBottomNavBar(),
        // ignore: prefer_const_constructors
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          color: Colors.white,
          onPressed: _signOut,
          icon: const Icon(Icons.logout),
        ),
      ],
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Get.to(() => const AtualizaPerfil());
          },
          icon: const Icon(Icons.menu_outlined)),
    );
  }
}
