import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';

class CardModeloComentario extends StatelessWidget {
  const CardModeloComentario({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: kDefaultPadding / 2,
      ),
      width: size.width * 0.9,
      height: size.height * 0.1,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: kPrimaryColor,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, right: 10.0, left: 10.0, bottom: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: kPrimaryColor.withOpacity(0.2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                  child: Container(
                    margin: const EdgeInsets.only(right: kDefaultPadding / 4),
                    height: size.height * 0.015,
                    width: size.width * 0.2,
                    color: kPrimaryColor.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 30.0, right: 30.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: kDefaultPadding / 4,
                  ),
                  height: size.height * 0.01,
                  color: kPrimaryColor.withOpacity(0.2),
                ),
                Container(
                  height: size.height * 0.01,
                  color: kPrimaryColor.withOpacity(0.2),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
