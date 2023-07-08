import 'package:flutter/material.dart';

class HeaderInicio extends StatelessWidget {
  const HeaderInicio(
      {super.key,
      required this.size,
      required this.image,
      required this.altura});

  final Size size;
  final ImageProvider<Object> image;
  final double altura;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffe0e9f8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 50),
            blurRadius: 35,
            color: Color(0xffe0e9f8),
          ),
        ],
      ),
      height: altura,
      width: size.width,
      margin: const EdgeInsets.only(bottom: 35),
      child: Image(image: image),
    );
  }
}
