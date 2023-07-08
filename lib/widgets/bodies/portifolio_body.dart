import 'package:flutter/material.dart';
import 'package:getx/repositories/get_image_perfil.dart';
import 'package:getx/util/tema.dart';

class PortifolioBody extends StatelessWidget {
  const PortifolioBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          ProjectContainer(size: size),
        ],
      ),
    );
  }
}

class ProjectContainer extends StatelessWidget {
  const ProjectContainer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: size.height * 0.35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: kPrimaryColor,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: size.height * 0.25,
                width: size.width - 16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    child: GetImagemPerfil(fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                      child: Text(
                        'Título',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 4.0, bottom: 8.0, left: 8.0),
                      child: Text('descrição'),
                    )
                  ],
                ),
                height: size.height * 0.1,
                width: size.width - 16,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(204, 220, 248, 1),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
