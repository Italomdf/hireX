import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({
    super.key,
    required this.size,
    required this.hint,
    required this.icone,
    required this.onChanged,
    this.obscure = false,
    this.validator,
    required this.controller,
  });
  final Icon icone;
  final Size size;
  final String hint;
  final ValueChanged<String> onChanged;
  final bool obscure;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFieldContainer(
        size: size,
        child: TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscure,
          onChanged: onChanged,
          decoration: InputDecoration(
              border: InputBorder.none, icon: icone, hintText: hint),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    required this.size,
    required this.child,
  });
  final Widget child;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: const Color(0xffe0e9f8), borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
