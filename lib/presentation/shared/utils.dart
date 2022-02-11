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
  bool isValidPassword() {
    return RegExp(r'.{6,}$')
        .hasMatch(this);
  }
}