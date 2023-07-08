import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.4,
              margin: const EdgeInsets.all(kDefaultPadding / 2),
              height: 2,
              color: kPrimaryColor,
            ),
            const Text(
              'ou',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: size.width * 0.4,
              margin: const EdgeInsets.all(kDefaultPadding / 2),
              height: 2,
              color: kPrimaryColor,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: size.width * 0.8,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xffe0e9f8),
                      borderRadius: BorderRadius.circular(29)),
                  child: Material(
                    color: const Color(0xffe0e9f8),
                    child: Row(
                      children: [
                        Ink.image(
                          height: size.height * 0.05,
                          width: size.width * 0.2,
                          fit: BoxFit.contain,
                          image: const AssetImage('assets/images/google_icon.png'),
                        ),
                        const Text(
                          'Continue com Google',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
