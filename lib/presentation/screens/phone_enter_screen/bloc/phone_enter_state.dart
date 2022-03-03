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