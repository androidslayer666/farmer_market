import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/cart/cart.dart';
import '../../../../../data/models/order/order.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState(
      {
        @Default(Cart()) Cart cart,
      }) = _Initial;
}