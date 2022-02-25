import 'dart:typed_data';

import 'package:farmer_market/repository/models/api/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../repository/models/user/user.dart';

part 'user_detail_state.freezed.dart';

enum UserDetailStatus { success, failure, unknown }

@freezed
class UserDetailState with _$UserDetailState {
  const factory UserDetailState(
      {String? name,
      User? existedUser,
          String? str,
      bool? haveUserInfoOnServer,
      String? description,
      String? addressQuery,
      Address? address,
      List<Address>? addresses,
      bool? isLoading,
      bool? isImageLoading,
      bool? logOutIsClicked,
      UserDetailStatus? userDetailStatus,
      Uint8List? avatarFile}) = _Initial;
}
