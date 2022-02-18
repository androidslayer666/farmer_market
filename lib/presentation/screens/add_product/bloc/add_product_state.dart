import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../repository/models/product.dart';

part 'add_product_state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState(
      {String? name,
      String? existedName,
      String? description,
      String? existedDescription,
      String? price,
      String? existedPrice,
      Unit? unit,
      Unit? existedUnit,
      bool? isLoading,
      bool? isImageLoading,
      bool? confirmIsClicked,
      Uint8List? productImage}) = _Initial;
}
