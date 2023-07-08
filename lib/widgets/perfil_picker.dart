import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';
import 'package:image_picker/image_picker.dart';

class PerfilPicker extends StatefulWidget {
  PerfilPicker({
    super.key,
    required this.callback,
    required this.image,
  });
  final Future<XFile?> Function() callback;
  XFile? image;

  @override
  State<PerfilPicker> createState() => _PerfilPickerState();
}

class _PerfilPickerState extends State<PerfilPicker> {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(clipBehavior: Clip.none, children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: kPrimaryColor,
          backgroundImage: (widget.image == null)
              ? null
              : FileImage(File(widget.image!.path)),
          child: (widget.image == null)
              ? const Icon(
                  Icons.person,
                  size: 45,
                )
              : null,
        ),
        Positioned(
            bottom: -15,
            right: -40,
            child: RawMaterialButton(
              onPressed: () async {
                XFile? newImage = await widget.callback();
                setState(() {
                  widget.image = newImage;
                });
              },
              elevation: 2.0,
              fillColor: const Color(0xFFF5F6F9),
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: kPrimaryColor,
                size: 20,
              ),
            )),
      ]),
    );
  }
}
