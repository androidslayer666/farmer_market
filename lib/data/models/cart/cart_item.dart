import 'package:freezed_annotation/freezed_annotation.dart';

import '../product/product.dart';

part 'cart_item.freezed.dart';

part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    @JsonKey(toJson: productToJson)
    Product? product,
    @Default(1) int qty,
  }) = _Initial;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}


Map<String, dynamic>? productToJson(Product? product) {
  return product?.toJson();
}