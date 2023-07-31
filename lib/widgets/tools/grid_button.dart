import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';

class BotaodeGrid extends StatelessWidget {
  BotaodeGrid({
    super.key,
    required this.size,
    required this.icone,
  });

  final Size size;
  IconData? icone;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: kPrimaryColor, width: 3), //<-- SEE HERE
          ),
          onPressed: () {},
          child: Container(
            width: size.width / 3,
            height: size.height * .15,
            child: Icon(
              icone,
              color: kPrimaryColor,
              size: 40,
            ),
          ),
        ));
  }
}
