import 'package:equatable/equatable.dart';

enum PhoneEnterStatus { success, failure, unknown }

class PhoneEnterState extends Equatable {
  const PhoneEnterState(
      {this.phoneIsValid = true,
      this.codeIsValid = true,
      this.phone = '+79200657987',
      this.code = '123123',
      this.isLoading = false,
      this.codeIsSent = false,
      this.loginStatus = PhoneEnterStatus.unknown,
      this.onCodeConfirmedDo});

  final bool phoneIsValid;
  final bool codeIsValid;
  final String phone;
  final String code;
  final bool isLoading;
  final bool codeIsSent;
  final PhoneEnterStatus loginStatus;
  final Function(String)? onCodeConfirmedDo;

  PhoneEnterState copyWith(
      {bool? phoneIsValid,
      bool? codeIsValid,
      String? phone,
      String? code,
      bool? isLoading,
      bool? codeIsSent,
      PhoneEnterStatus? loginStatus,
      Function(String)? onCodeConfirmedDo}) {
    return PhoneEnterState(
        phoneIsValid: phoneIsValid ?? this.phoneIsValid,
        codeIsValid: codeIsValid ?? this.codeIsValid,
        phone: phone ?? this.phone,
        code: code ?? this.code,
        isLoading: isLoading ?? this.isLoading,
        codeIsSent: codeIsSent ?? this.codeIsSent,
        loginStatus: loginStatus ?? this.loginStatus,
        onCodeConfirmedDo: onCodeConfirmedDo ?? this.onCodeConfirmedDo);
  }

  @override
  List<Object?> get props => [
        phoneIsValid,
        codeIsValid,
        phone,
        code,
        isLoading,
        codeIsSent,
        loginStatus,
        onCodeConfirmedDo
      ];
}
