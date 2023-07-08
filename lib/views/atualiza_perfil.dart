import 'package:flutter/material.dart';
import 'package:getx/widgets/bodies/atualiza_perfil_body.dart';

class AtualizaPerfil extends StatefulWidget {
  const AtualizaPerfil({super.key});

  @override
  State<AtualizaPerfil> createState() => _AtualizaPerfilState();
}

class _AtualizaPerfilState extends State<AtualizaPerfil> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: AtualizaPerfilBody()),
    );
  }
}
