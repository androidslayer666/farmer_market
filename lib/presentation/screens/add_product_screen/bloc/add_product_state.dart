import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/product/category.dart';
import '../../../../data/models/product/product.dart';


part 'add_product_state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState(
      {String? name,
          String? id,
      String? description,
      String? price,
          String? pictureUrl,
      Unit? unit,
          Category? category,
      bool? isLoading,
      bool? isImageLoading,
      bool? confirmIsClicked,
      bool? deletingIsSuccessful,
      bool? addingIsSuccessful,
      Uint8List? productImage}) = _Initial;
}
