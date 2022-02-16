import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_detail_state.freezed.dart';

enum UserDetailStatus { success, failure, unknown }

@freezed
class UserDetailState with _$UserDetailState {
  const factory UserDetailState(
      {TextEditingController? name,
      bool? phoneIsValid,
      String? phone,
      bool? haveUserInfoOnServer,
      TextEditingController? description,
      bool? isLoading,
      bool? isImageLoading,
      bool? logOutIsClicked,
      UserDetailStatus? userDetailStatus,
      Uint8List? avatarFile}) = _Initial;
}
