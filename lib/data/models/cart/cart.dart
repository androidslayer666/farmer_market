import 'package:freezed_annotation/freezed_annotation.dart';

import '../convertors.dart';
import 'cart_item.dart';

part 'cart.freezed.dart';

part 'cart.g.dart';

@freezed
class Cart with _$Cart {
  const factory Cart(
      {String? id,
      String? userId,
      @JsonKey(toJson: listCartItemsToJson)
      @Default([])
          List<CartItem> cartItems,
      DateTime? dateCreated}) = _Initial;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}


