import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../data/models/cart/cart.dart';
import '../../../../../../data/models/cart/cart_item.dart';
import '../../../../../../data/models/user/user.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState(
      {
        @Default(Cart()) Cart cart,
        Map<User?, List<CartItem>>? mapUserToItems,
        bool? successfullyAddedToCart,
        bool? successfullyDeletedToCart,
      }) = _Initial;
}