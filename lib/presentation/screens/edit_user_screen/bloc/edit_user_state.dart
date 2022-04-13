import 'dart:typed_data';

import 'package:farmer_market/data/models/api/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/user/user.dart';

part 'edit_user_state.freezed.dart';

@freezed
class EditUserState with _$EditUserState {
  const factory EditUserState(
      {User? user,
      String? addressQuery,
      List<Address>? addresses,
      bool? isLoading,
      bool? isImageLoading,
      bool? logOutIsClicked,
      bool? nameIsValid,
      bool? descriptionIsValid,
      bool? addressIsValid,
      bool? saveClickedWhenInputIsNotValid,
          bool? changesSaved,
      Uint8List? avatarFile}) = _Initial;
}
