import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/views/cadastro_cliente_page.dart';
import 'package:getx/views/login_page.dart';

class BotoesIniciais extends StatelessWidget {
  const BotoesIniciais({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ))),
                    onPressed: () {},
                    child: SizedBox(
                        height: size.height * 0.05,
                        child: const Center(child: Text('Sou um profissional'))),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ))),
                    onPressed: () {
                      Get.to(() => const CadastroClientePage());
                    },
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: const Center(
                        child: Text(
                          'Estou buscando um profissional',
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
                onPressed: () {
                  Get.to(() => const LoginPage());
                },
                child: const Text(
                  'Já sou cadastrado',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
