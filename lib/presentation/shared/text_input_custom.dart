import 'package:flutter/material.dart';

class TextInputCustom extends StatelessWidget {
  final TextEditingController controller;
  final int? lines;
  final String hint;
  final bool isPass;
  final Function(String) onChanged;

  const TextInputCustom(
      {Key? key,
      required this.controller,
      this.lines = 1,
      required this.hint,
      this.isPass = false,
        required this.onChanged
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextField(
        style: TextStyle(fontSize: 20),
        // controller: controller,
        maxLines: lines,
        onChanged: (String value) => onChanged(value),
        obscureText: isPass,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: hint,
            filled: true,
            fillColor: Colors.brown.shade50),
      ),
    );
  }
}
