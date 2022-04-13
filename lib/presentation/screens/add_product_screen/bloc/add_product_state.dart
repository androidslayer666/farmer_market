import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/product/product.dart';

part 'add_product_state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState(
      {Product? product,
      String? id,
      String? pictureUrl,
      bool? isLoading,
      bool? isImageLoading,
      bool? confirmIsClicked,
      bool? deletingIsSuccessful,
      bool? addingIsSuccessful,
      bool? nameIsValid,
      bool? descriptionIsValid,
      bool? priceIsValid,
      bool? measureIsValid,
      bool? categoryIsValid,
      bool? saveClickedWhenInputIsNotValid,
      Uint8List? productImage}) = _Initial;
}
