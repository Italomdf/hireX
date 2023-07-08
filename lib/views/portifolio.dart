import 'package:flutter/material.dart';
import 'package:getx/widgets/bodies/portifolio_body.dart';

class Portifolio extends StatelessWidget {
  const Portifolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: PortifolioBody()),
    );
  }
}
