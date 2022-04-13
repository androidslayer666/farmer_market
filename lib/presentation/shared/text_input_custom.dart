import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gradient_mask.dart';

class TextInputCustom extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icon;
  final int? lines;
  final String? hint;
  final String? initialValue;
  final bool isPass;
  final FocusNode? node;
  final String? errorText;
  final TextInputType? textInputType;
  final TextInputFormatter? textInputFormatter;
  final Function(String)? onChanged;

  const TextInputCustom(
      {Key? key,
      this.icon,
      this.node,
      this.controller,
      this.lines = 1,
      this.textInputType,
      this.hint,
      this.isPass = false,
      this.onChanged,
      this.textInputFormatter,
      this.initialValue, this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextFormField(
        // handling of initial value update
        //key: Key(initialValue.toString()),
        cursorColor: Theme.of(context).primaryColor,
        initialValue: initialValue,
        style: TextStyle(fontSize: 18, fontFamily: 'Roboto', color: Theme.of(context).indicatorColor),
        controller: controller,
        keyboardType: textInputType,
        inputFormatters: [if (textInputFormatter != null) textInputFormatter!],
        maxLines: lines,
        focusNode: node,
        onChanged: onChanged != null ? (String value) => onChanged!(value) : null,
        obscureText: isPass,
        decoration: InputDecoration(
          errorText: errorText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          helperStyle: TextStyle(color: Theme.of(context).indicatorColor),
          labelStyle: TextStyle(color: Theme.of(context).indicatorColor),
          icon: icon != null ? RadiantGradientMask(
              first: Theme.of(context).primaryColor,
              second: Colors.white,
              child: Icon(icon,
                  color: Theme.of(context).primaryColor.withOpacity(0.8))) : null,
          border: const UnderlineInputBorder(),
          labelText: hint,
        ),
      ),
    );
  }
}
