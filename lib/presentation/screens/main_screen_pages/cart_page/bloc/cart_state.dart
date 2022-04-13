import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/cart/cart.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState(
      {
        @Default(Cart()) Cart cart,
        bool? successfullyAddedToCart
      }) = _Initial;
}