import 'package:freezed_annotation/freezed_annotation.dart';

part 'authorization_state.freezed.dart';

enum PhoneLoginStatus { success, failure, unknown, awaitingCode, codeIsSent, codeSubmitted }

@freezed
class AuthorizationState with _$AuthorizationState {
  const factory AuthorizationState(
      {@Default(true) bool? phoneIsValid,
        @Default(true) bool? codeIsValid,
        @Default('')String?  phone,
        @Default('') String? code,
        @Default(false) bool? haveUserInfoOnServer,
        @Default(PhoneLoginStatus.unknown) PhoneLoginStatus loginStatus,
            @Default(false) bool timerIsSet,
        Function(String)? onCodeConfirmedDo}) = _Initial;
}