import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:getx/repositories/get_image_perfil.dart';
import 'package:getx/repositories/get_users_images.dart';
import 'package:getx/util/tema.dart';

class CardProfissionais extends StatelessWidget {
  CardProfissionais(
      {super.key,
      required this.image,
      required this.title,
      required this.country,
      required this.price,
      required this.press,
      required this.cargo,
      required this.espec,
      required this.docIDs,
      required this.indice});

  final String image, country, cargo, espec;
  final Widget title;
  final int price;
  final Callback press;
  List<String> docIDs;
  int indice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: size.width * 0.7,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                margin: const EdgeInsets.only(
                  left: kDefaultPadding * 2,
                  top: kDefaultPadding,
                  bottom: kDefaultPadding * 2.5,
                ),
                width: size.width * 0.8,
                height: size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: Card(
                elevation: 15,
                shadowColor: kPrimaryColor.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: size.width * 0.45,
                  width: size.width * 0.40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GetUsersImages(
                      documentId: docIDs[indice],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                right: 0,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding * 2,
                    top: kDefaultPadding,
                    bottom: kDefaultPadding * 2.5,
                  ),
                  height: size.width * 0.5,
                  width: size.width * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: kDefaultPadding,
                        left: kDefaultPadding,
                        top: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title,
                        Text(
                          cargo,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Text(
                          espec,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding * 2,
                    top: kDefaultPadding,
                    bottom: kDefaultPadding * 2.5,
                  ),
                  width: size.width * 0.6,
                  height: size.width * 0.5,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: RatingBar.builder(
                            itemSize: 30,
                            initialRating: 3,
                            minRating: 1,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.size,
    required this.image,
    required this.press,
    required this.title,
    required this.country,
    required this.price,
  });

  final Size size;
  final String image;
  final Callback press;
  final String title;
  final String country;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5),
      width: size.width * 0.4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(
                    10)), // Adjust the value as per your preference
            child: SizedBox(
              width: size.width * 0.4,
              height: size.width * 0.4,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23))
                  ]),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.labelLarge),
                        TextSpan(
                          text: country.toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
