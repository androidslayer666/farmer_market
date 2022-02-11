

import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInNameChanged extends SignInEvent {
  const SignInNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class SignInPhoneChanged extends SignInEvent {
  const SignInPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class SignInPasswordChanged extends SignInEvent {
  const SignInPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SignInImageAddClicked extends SignInEvent {
  const SignInImageAddClicked();



  @override
  List<Object> get props => [];
}

class SignInSubmitted extends SignInEvent {
  const SignInSubmitted();
}