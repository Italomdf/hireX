import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/widgets/listaFireN.dart';

class ScaffoldComentarios extends StatelessWidget {
  ScaffoldComentarios({
    super.key,
    required this.size,
  });

  final Size size;
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<String> docIDs = [];

  Future<List<String>> getLista(docIDs) async {
    docIDs.clear();
    var firebaseUser = FirebaseAuth.instance.currentUser;

    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .collection('despesas')
        .get();

    for (var document in snapshot.docs) {
      var valor = document.data()['valor'];
      docIDs.add(document.reference.id);
    }

    return docIDs;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: FutureBuilder(
                  future: getLista(docIDs),
                  builder: (context, indice) {
                    return ListaFireN(
                        docIDs: docIDs, formController: formController);
                  }),
            );
          },
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: kDefaultPadding / 4),
                    child: Text(
                      'Avaliações',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.only(right: kDefaultPadding / 4),
                      height: 7,
                      color: kPrimaryColor.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ],
          ),
          RatingBar.builder(
            itemSize: 30,
            initialRating: 3,
            minRating: 1,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          CardModeloComentario(size: size),
        ],
      ),
    );
  }
}

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
