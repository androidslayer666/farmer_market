import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputCustom extends StatelessWidget {
  final TextEditingController? controller;
  final Icon? icon;
  final int? lines;
  final String hint;
  final String? initialValue;
  final bool isPass;
  final FocusNode? node;
  final TextInputType? textInputType;
  final TextInputFormatter? textInputFormatter;
  final Function(String) onChanged;

  const TextInputCustom({Key? key,
    this.icon,
    this.node,
    this.controller,
    this.lines = 1,
    this.textInputType,
    required this.hint,
    this.isPass = false,
    required this.onChanged,
    this.textInputFormatter,
    this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextFormField(
        initialValue: initialValue,
        style: const TextStyle(fontSize: 20, fontFamily: 'Roboto'),
        controller: controller,
        keyboardType: textInputType,
        inputFormatters: [if (textInputFormatter != null) textInputFormatter!],
        maxLines: lines,
        focusNode: node,
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
