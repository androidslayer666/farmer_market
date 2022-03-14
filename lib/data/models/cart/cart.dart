import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_item.dart';

part 'cart.freezed.dart';

part 'cart.g.dart';

@freezed
class Cart with _$Cart {
  const factory Cart(
      {String? id,
      String? userId,
      @JsonKey(toJson: _listCartItemsToJson)
      @Default([])
          List<CartItem> cartItems,
      DateTime? dateCreated}) = _Initial;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}


List<Map<String, dynamic>>? _listCartItemsToJson(List<CartItem>? listCartItems) {
  if(listCartItems != null) {
    return listCartItems.map((cartItem) => cartItem.toJson()).toList();
  }
  return null;
}