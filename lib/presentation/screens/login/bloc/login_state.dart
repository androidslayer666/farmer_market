import 'package:equatable/equatable.dart';

enum LoginStatus {success, failure, unknown}

class LoginState extends Equatable {
  const LoginState(
      {this.phoneIsValid = true,
      this.passwordIsValid = true,
      this.phone = '+79200657987',
      this.password = 'wzyan762',
      this.isLoading = false,
      this.loginStatus = LoginStatus.unknown});

  final bool phoneIsValid;
  final bool passwordIsValid;
  final String phone;
  final String password;
  final bool isLoading;
  final LoginStatus loginStatus;

  LoginState copyWith(
      {bool? phoneIsValid,
      bool? passwordIsValid,
      String? phone,
      String? password,
      bool? isLoading,
        LoginStatus? loginStatus}) {
    return LoginState(
        phoneIsValid: phoneIsValid ?? this.phoneIsValid,
        passwordIsValid: passwordIsValid ?? this.passwordIsValid,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  List<Object> get props => [phoneIsValid, passwordIsValid, phone, password, isLoading, loginStatus];
}
