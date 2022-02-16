

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PhoneEnterEvent extends Equatable {
  const PhoneEnterEvent();

  @override
  List<Object> get props => [];
}

class PhoneEnterPhoneChanged extends PhoneEnterEvent {
  const PhoneEnterPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class PhoneEnterCodeChanged extends PhoneEnterEvent {
  const PhoneEnterCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

class PhoneEnterSubmitted extends PhoneEnterEvent {
  const PhoneEnterSubmitted(this.context);
  final BuildContext context;
}

class PhoneCodeSent extends PhoneEnterEvent{
  const PhoneCodeSent({required this.onCodeSubmitted});
  final Function(String) onCodeSubmitted;
}

class OnCodeSubmitted extends PhoneEnterEvent{
  const OnCodeSubmitted();
}


