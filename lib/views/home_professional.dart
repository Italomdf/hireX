import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx/views/welcome_page.dart';
import 'package:getx/widgets/bodies/home_professional_body.dart';
import 'package:getx/widgets/home_drawer.dart';
import 'package:getx/widgets/my_bottom_navBar.dart';

class HomeProfessional extends StatefulWidget {
  const HomeProfessional({super.key});

  @override
  State<HomeProfessional> createState() => _HomeProfessionalState();
}

class _HomeProfessionalState extends State<HomeProfessional> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _signOut() async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: ((context) => const WelcomePage())));
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        drawer: const Drawer(
          child: HomeDrawer(),
        ),
        body: const SafeArea(child: HomeProfessionalBody()),
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
    );
  }
}
