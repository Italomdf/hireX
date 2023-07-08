import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';

//pega valor das despesas no firebase
class GetUsersImages extends StatelessWidget {
  GetUsersImages({super.key, required this.fit, required this.documentId});
  BoxFit? fit;
  final String documentId;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final storageRef = FirebaseStorage.instance.ref();
    var imageRef =
        storageRef.child('images/user/$documentId.jpg').getDownloadURL();

    return FutureBuilder<String>(
      future: imageRef,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        } else if (snapshot.hasError) {
          return const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 225, 230, 225),
            child: Icon(
              Icons.add_a_photo,
              color: kPrimaryColor,
              size: 50,
            ),
          );
        } else {
          return Image.network(
            snapshot.data!,
            fit: fit,
          );
        }
      },
    );
  }
}
