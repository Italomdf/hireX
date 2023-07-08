import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:getx/util/tema.dart';

class Barbearias extends StatelessWidget {
  const Barbearias({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          BarbeariasCard(
            image: 'assets/images/planta.jpg',
            press: () {},
          ),
          BarbeariasCard(
            image: 'assets/images/capa.png',
            press: () {},
          ),
        ],
      ),
    );
  }
}

class BarbeariasCard extends StatelessWidget {
  const BarbeariasCard({
    super.key,
    required this.press,
    required this.image,
  });
  final Callback press;
  final String image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding / 2),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
