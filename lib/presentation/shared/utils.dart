import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

extension PhoneValidator on String {
  bool isValidPhone() {
    return RegExp(
        r'^(?:[+0]9)?[0-9]{10}$')
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
  final firstScobe = 3;
  final secondScobe = 6;
  final delimiter = ' ';
  final maxLength = 16;
  final delimitersAfter = [3, 5];

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    print("New value length : ${newValue.text.length}");


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
    if (newTextLength == firstScobe) {
      newText.write(
          newValue.text.substring(0, usedSubstringIndex = firstScobe - 1) +
              '(');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }

    if (newTextLength == secondScobe) {
      //newText.write('(');
      newText.write(
          newValue.text.substring(0, usedSubstringIndex = secondScobe) + ')');
      if (newValue.selection.end >= 2) selectionIndex += 1;
    }

    print("index : ${newValue.text.indexOf(')')}");

    for (var element in delimitersAfter) {
      if (newValue.text.contains(')') &&
          newTextLength ==
              newValue.text.indexOf(')') + element + 1 +delimitersAfter.indexOf(element)) {
        print("secondScobe + element : ${secondScobe + element}");
        newText.write(newValue.text.substring(
            0,
            usedSubstringIndex =
                secondScobe + element + 1 + delimitersAfter.indexOf(element)) +
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
