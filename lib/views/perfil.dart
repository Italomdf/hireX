import 'package:flutter/material.dart';
import 'package:getx/widgets/bodies/perfil_body.dart';
import 'package:getx/widgets/profissionais_em_destaque.dart';

class Perfil extends StatefulWidget {
  Perfil({super.key, required this.documentId});
  final String documentId;

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: PerfilBody(documentId: widget.documentId)),
    );
  }
}
