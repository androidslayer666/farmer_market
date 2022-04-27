

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class AuthorizationPhoneChanged extends AuthorizationEvent {
  const AuthorizationPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class AuthorizationCodeChanged extends AuthorizationEvent {
  const AuthorizationCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

class AuthorizationPhoneSubmitted extends AuthorizationEvent {
  const AuthorizationPhoneSubmitted(this.context);
  final BuildContext context;
}

class AuthorizationCodeSent extends AuthorizationEvent{
  const AuthorizationCodeSent({required this.onCodeSubmitted});
  final Function(String) onCodeSubmitted;

  @override
  List<Object> get props => [onCodeSubmitted];
}

class AuthorizationResetState extends AuthorizationEvent{
  const AuthorizationResetState();
}

class AuthorizationCodeSubmitted extends AuthorizationEvent{
  const AuthorizationCodeSubmitted();
}

class AuthorizationTimerIsOver extends AuthorizationEvent{
  const AuthorizationTimerIsOver();
}

