import 'package:flutter/material.dart';
import 'package:getx/widgets/bodies/welcome_body.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white, body: SafeArea(child: WelcomeBody()));
  }
}
