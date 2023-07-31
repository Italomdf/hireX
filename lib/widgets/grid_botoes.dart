import 'package:flutter/material.dart';
import 'package:getx/widgets/tools/grid_button.dart';

class GridBotoes extends StatelessWidget {
  const GridBotoes({
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
            BotaodeGrid(
              size: size,
              icone: Icons.radio_button_checked,
            ),
            BotaodeGrid(
              size: size,
              icone: Icons.radio_button_checked,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BotaodeGrid(
              size: size,
              icone: Icons.radio_button_checked,
            ),
            BotaodeGrid(
              size: size,
              icone: Icons.radio_button_checked,
            ),
          ],
        ),
      ],
    );
  }
}
