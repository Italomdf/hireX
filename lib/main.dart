import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/repositories/tools/rep_util.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/util/util.dart';
import 'package:getx/views/home.dart';
import 'package:getx/views/home_professional.dart';
import 'package:getx/views/login.dart';
import 'package:getx/views/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? rota;

  await Future.delayed(Duration(seconds: 0), () async {
    rota = await UtilRepository().determinaRotaInicial();
  });
  runApp(TreinoGetX(
    rota: rota,
  ));
}

class TreinoGetX extends StatelessWidget {
  TreinoGetX({super.key, this.rota});

  String? rota;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightThemeData(context),
      debugShowCheckedModeBanner: false,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/welcome' : rota,
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        '/homeProfissional': (context) => const HomeProfessional(),
      },
    );
  }
}
