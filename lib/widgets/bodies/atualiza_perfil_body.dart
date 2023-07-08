import 'package:flutter/material.dart';

import 'package:getx/widgets/form_update.dart';

class AtualizaPerfilBody extends StatelessWidget {
  const AtualizaPerfilBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        Center(child: FormAtualiza()),
      ]),
    );
  }
}
