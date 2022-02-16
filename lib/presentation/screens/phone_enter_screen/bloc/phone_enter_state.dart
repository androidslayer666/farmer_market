import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_enter_state.freezed.dart';

enum PhoneLoginStatus { success, failure, unknown }

@freezed
class PhoneEnterStateFreezed with _$PhoneEnterStateFreezed {
  const factory PhoneEnterStateFreezed(
      {@Default(true) bool? phoneIsValid,
        @Default(true) bool? codeIsValid,
        @Default('+79200657987')String?  phone,
        @Default('123123') String? code,
        @Default(false) bool? haveUserInfoOnServer,
        @Default(false) bool? isLoading,
        @Default(false) bool? codeIsSent,
        @Default(PhoneLoginStatus.unknown) PhoneLoginStatus? loginStatus,
        Function(String)? onCodeConfirmedDo}) = _Initial;
}

// class PhoneEnterState extends Equatable {
//   const PhoneEnterState(
//       {this.phoneIsValid = true,
//       this.codeIsValid = true,
//       this.phone = '+79200657987',
//       this.code = '123123',
//       this.isLoading = false,
//       this.codeIsSent = false,
//       this.haveUserInfoOnServer,
//       this.loginStatus = PhoneLoginStatus.unknown,
//       this.onCodeConfirmedDo});
//
//   final bool phoneIsValid;
//   final bool codeIsValid;
//   final bool? haveUserInfoOnServer;
//   final String phone;
//   final String code;
//   final bool isLoading;
//   final bool codeIsSent;
//   final PhoneLoginStatus loginStatus;
//   final Function(String)? onCodeConfirmedDo;
//
//   PhoneEnterState copyWith(
//       {bool? phoneIsValid,
//       bool? codeIsValid,
//       String? phone,
//       String? code,
//       bool? haveUserInfoOnServer,
//       bool? isLoading,
//       bool? codeIsSent,
//       PhoneLoginStatus? loginStatus,
//       Function(String)? onCodeConfirmedDo}) {
//     return PhoneEnterState(
//         phoneIsValid: phoneIsValid ?? this.phoneIsValid,
//         codeIsValid: codeIsValid ?? this.codeIsValid,
//         phone: phone ?? this.phone,
//         code: code ?? this.code,
//         haveUserInfoOnServer: haveUserInfoOnServer ?? this.haveUserInfoOnServer,
//         isLoading: isLoading ?? this.isLoading,
//         codeIsSent: codeIsSent ?? this.codeIsSent,
//         loginStatus: loginStatus ?? this.loginStatus,
//         onCodeConfirmedDo: onCodeConfirmedDo ?? this.onCodeConfirmedDo);
//   }
//
//   @override
//   List<Object?> get props => [
//         phoneIsValid,
//         codeIsValid,
//         phone,
//         code,
//         isLoading,
//         haveUserInfoOnServer,
//         codeIsSent,
//         loginStatus,
//         onCodeConfirmedDo
//       ];
// }

