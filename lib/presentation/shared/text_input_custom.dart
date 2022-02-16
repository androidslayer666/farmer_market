import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputCustom extends StatelessWidget {
  final TextEditingController controller;
  final Icon? icon;
  final int? lines;
  final String hint;
  final bool isPass;
  final TextInputType? textInputType;
  final TextInputFormatter? textInputFormatter;
  final Function(String) onChanged;

  const TextInputCustom({Key? key,
    this.icon,
    required this.controller,
    this.lines = 1,
    this.textInputType,
    required this.hint,
    this.isPass = false,
    required this.onChanged,
    this.textInputFormatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextField(
        style: const TextStyle(fontSize: 20, fontFamily: 'Roboto'),
        controller: controller,
        keyboardType: textInputType,
        inputFormatters: [if (textInputFormatter != null) textInputFormatter!],
        maxLines: lines,
        onChanged: (String value) => onChanged(value),
        obscureText: isPass,
        decoration: InputDecoration(
            icon: icon,
            border: const UnderlineInputBorder(),
            labelText: hint,
            ),
      ),
    );
  }
}
