import 'dart:typed_data';

import 'package:equatable/equatable.dart';

enum SignInStatus { success, failure, unknown }

class SignInState extends Equatable {
  const SignInState(
      {this.name = 'oleg',
      this.phoneIsValid = true,
      this.passwordIsValid = true,
      this.phone = '+79200657987',
      this.password = 'wzyan762',
      this.isLoading = false,
      this.signInStatus = SignInStatus.unknown,
      this.image});

  final String name;
  final bool phoneIsValid;
  final bool passwordIsValid;
  final String phone;
  final String password;
  final bool isLoading;
  final SignInStatus signInStatus;
  final Uint8List? image;

  SignInState copyWith(
      {String? name,
      bool? phoneIsValid,
      bool? passwordIsValid,
      String? phone,
      String? password,
      bool? isLoading,
      SignInStatus? signInStatus,
      Uint8List? image}) {
    return SignInState(
      name: name ?? this.name,
      phoneIsValid: phoneIsValid ?? this.phoneIsValid,
      passwordIsValid: passwordIsValid ?? this.passwordIsValid,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      signInStatus: signInStatus ?? this.signInStatus,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phoneIsValid,
        passwordIsValid,
        phone,
        password,
        isLoading,
        signInStatus,
        image
      ];
}
