import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getx/repositories/get_image_perfil.dart';
import 'package:getx/repositories/tools/getters_firebase.dart';
import 'package:getx/repositories/tools/rep_util.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/util/util.dart';

class RowWithImageAndRating extends StatefulWidget {
  RowWithImageAndRating({
    super.key,
    required this.size,
    required this.imagem,
    required this.documentId,
  });

  final Size size;
  Widget imagem;
  final String documentId;

  @override
  State<RowWithImageAndRating> createState() => _RowWithImageAndRatingState();
}

class _RowWithImageAndRatingState extends State<RowWithImageAndRating> {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ButtonsColumn(size: widget.size),
        ),
        Stack(children: [
          GestureDetector(
            onTap: () async {
              await UtilRepository().atualizaFoto();
              setState(() {});
            },
            child: Container(
              height: widget.size.height * 0.5,
              width: widget.size.width * 0.75,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 225, 230, 225),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(63),
                  topLeft: Radius.circular(63),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(63),
                  topLeft: Radius.circular(63),
                ),
                child: widget.imagem,
              ),
            ),
          ),
          Positioned(
            top: widget.size.height * 0.43,
            right: 0,
            child: Container(
              height: widget.size.height * 0.07,
              width: widget.size.width * 0.75,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(63),
                      bottomLeft: Radius.circular(63)),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder<double?>(
                    future:
                        GettersFirebase().calcularMediaNotas(widget.documentId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }
}

class ButtonsColumn extends StatelessWidget {
  const ButtonsColumn({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(63),
                          topRight: Radius.circular(63)),
                    ))),
                onPressed: () {
                  Get.back();
                },
                child: const Icon(Icons.keyboard_backspace)),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(63)))),
              onPressed: () {},
              child: const Icon(Icons.chat)),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(63)))),
              onPressed: () {},
              child: const Icon(Icons.star)),
        ],
      ),
    );
  }
}
