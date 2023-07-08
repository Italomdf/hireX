import 'package:flutter/material.dart';
import 'package:getx/repositories/get_image_perfil.dart';
import 'package:getx/repositories/tools/rep_util.dart';
import 'package:getx/util/util.dart';

class IconePerfil extends StatefulWidget {
  IconePerfil(
      {super.key,
      required this.size,
      required this.coefSize,
      required this.raio});
  final Size size;
  double coefSize;
  double raio;

  @override
  State<IconePerfil> createState() => _IconePerfilState();
}

class _IconePerfilState extends State<IconePerfil> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await UtilRepository().atualizaFoto();
        setState(() {});
      },
      child: Column(
        children: [
          SizedBox(
            width: widget.size.width * widget.coefSize,
            height: widget.size.width * widget.coefSize,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.raio),
                child: GetImagemPerfil(fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
