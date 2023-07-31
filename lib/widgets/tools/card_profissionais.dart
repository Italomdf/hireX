import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:getx/repositories/get_users_images.dart';
import 'package:getx/repositories/tools/getters_firebase.dart';
import 'package:getx/util/tema.dart';

// ignore: must_be_immutable
class CardProfissionais extends StatelessWidget {
  CardProfissionais({
    super.key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
    required this.cargo,
    required this.espec,
    required this.docID,
    required this.boxDecoration,
    this.corSombra = kPrimaryColor,
  });

  final String image, country, cargo, espec;
  final Widget title;
  final int price;
  final Callback press;
  String docID;
  Color corSombra;
  BoxDecoration boxDecoration;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Stack(
        children: [
          //container principal
          Positioned(
            child: Container(
                margin: const EdgeInsets.only(
                    left: kDefaultPadding * 2,
                    top: kDefaultPadding,
                    bottom: kDefaultPadding),
                width: size.width * 0.8,
                height: size.height * 0.25,
                decoration: boxDecoration),
          ),
          //container imagem
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
                    documentId: docID,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          //container texto
          Positioned(
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(
                  left: kDefaultPadding * 2,
                  top: kDefaultPadding,
                  bottom: kDefaultPadding,
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
                      FutureBuilder<double?>(
                        future: GettersFirebase().calcularMediaNotas(docID),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // If the future is still waiting for the data, return a loading indicator or a placeholder.
                            return CircularProgressIndicator(); // You can customize the loading indicator as per your requirement.
                          } else if (snapshot.hasError) {
                            // If there's an error while fetching the data, handle the error here.
                            return Text(
                              "Error: ${snapshot.error}",
                            );
                          } else {
                            // If the future has completed and the data is available, parse it to double.
                            double? rating = snapshot.data;

                            if (rating == null) {
                              // If the data is null, handle it accordingly, e.g., show a message.
                              return Text(
                                "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              // If the data is not null, display the rating as usual.
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Nota: ${rating.toStringAsFixed(1)} | 5.0',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              )),
          //container estrelas
          Positioned(
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.only(
                  left: kDefaultPadding * 2,
                  top: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                width: size.width * 0.6,
                height: size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FutureBuilder<double?>(
                          future: GettersFirebase().calcularMediaNotas(docID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // If the future is still waiting for the data, return a loading indicator or a placeholder.
                              return CircularProgressIndicator(); // You can customize the loading indicator as per your requirement.
                            } else if (snapshot.hasError) {
                              // If there's an error while fetching the data, handle the error here.
                              return Text("Error: ${snapshot.error}");
                            } else {
                              // If the future has completed and the data is available, parse it to double.
                              double rating = snapshot.data ?? 0.0 ?? 0.0;

                              if (snapshot.data == null) {
                                // If the data is null, handle it accordingly, e.g., show a message.
                                return Text(
                                  "Sem avaliações.",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }

                              return RatingBarIndicator(
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                rating: rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 30.0,
                                direction: Axis.horizontal,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
