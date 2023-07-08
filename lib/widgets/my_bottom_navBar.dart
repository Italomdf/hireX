import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
      ),
      height: size.height * 0.05,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38))
      ], color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
            color: kPrimaryColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
            color: kPrimaryColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline_rounded),
            color: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
