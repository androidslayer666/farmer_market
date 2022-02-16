import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
  return null;
}

Future<Uint8List?> urlToUint8List(String? url) async {
  if (url != null){
    return  (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
  }
  return null;
}

extension PhoneValidator on String {
  bool isValidPhone() {
    return RegExp(
        r'^[\d\(\)\-+].{10,}$')
        .hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidCode() {
    return RegExp(r'.{6,}$')
        .hasMatch(this);
  }
}


class NumberTextInputFormatter extends TextInputFormatter {
  NumberTextInputFormatter({
    this.firstBrace = 3,
    this.secondBrace = 6,
    this.delimiter = ' ',
    this.maxLength = 16,
    this.delimitersAfter = const [3,5]
});

  int firstBrace;
  int secondBrace;
  String delimiter;
  int maxLength;
  List<int> delimitersAfter;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    //print("New value length : ${newValue.text.length}");


    if (oldValue.text.length > newValue.text.length) {
      return newValue;
    }

    if(newValue.text.length> maxLength){
      return oldValue;
    }

    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 1 && newValue.text[0] != '+') {
      newText.write('+');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength == firstBrace) {
      newText.write(
          newValue.text.substring(0, usedSubstringIndex = firstBrace - 1) +
              '(');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }

    if (newTextLength == secondBrace) {
      //newText.write('(');
      newText.write(
          newValue.text.substring(0, usedSubstringIndex = secondBrace) + ')');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }

    //print("index : ${newValue.text.indexOf(')')}");

    for (var element in delimitersAfter) {
      if (newValue.text.contains(')') &&
          newTextLength ==
              newValue.text.indexOf(')') + element + 1 + delimitersAfter.indexOf(element)) {
        //print("secondScobe + element : ${secondBrace + element}");
        newText.write(newValue.text.substring(
            0,
            usedSubstringIndex =
                secondBrace + element + 1 + delimitersAfter.indexOf(element)) +
            delimiter);
        if (newValue.selection.end >= 2) selectionIndex += 1;

      }
    }

    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
