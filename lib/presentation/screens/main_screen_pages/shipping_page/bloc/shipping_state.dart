import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/cart/cart.dart';
import '../../../../../data/models/order/order.dart';

part 'shipping_state.freezed.dart';

@freezed
class ShippingState with _$ShippingState {
  const factory ShippingState(
      {
        @Default([]) List<Order> listOrders,
        bool? orderUpdateResult
      }) = _Initial;
}