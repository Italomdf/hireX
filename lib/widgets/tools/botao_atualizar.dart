// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:getx/util/tema.dart';
import 'package:getx/widgets/tools/form_imput.dart';

class BotaoAtualizarDado extends StatefulWidget {
  BotaoAtualizarDado(
      {super.key,
      required this.icone,
      required this.texto,
      required this.controller,
      required this.hint,
      required this.onUpdatePressed});
  IconData? icone;
  Widget texto;
  TextEditingController controller = TextEditingController();
  final VoidCallback onUpdatePressed;
  String hint;

  @override
  State<BotaoAtualizarDado> createState() => _BotaoAtualizarDadoState();
}

class _BotaoAtualizarDadoState extends State<BotaoAtualizarDado> {
  bool tapped = true;

  final duration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: duration,
                child: tapped
                    ? GestureDetector(
                        onTap: () {
                          setState(() => tapped = !tapped);
                        },
                        child: Container(
                          width: size.width * 0.8,
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: Icon(
                                  widget.icone,
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(
                                  width: size.width * 0.5, child: widget.texto),
                            ],
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          RoundedInput(
                              size: size,
                              hint: widget.hint,
                              icone: Icon(widget.icone),
                              onChanged: (value) {},
                              controller: widget.controller),
                          IconButton(
                              onPressed: () {
                                if (widget.controller.text != '') {
                                  widget.onUpdatePressed();
                                }

                                setState(() => tapped = !tapped);
                              },
                              icon: const Icon(Icons.check_outlined))
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
