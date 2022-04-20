import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/order/order.dart';

part 'shipping_state.freezed.dart';

@freezed
class ShippingState with _$ShippingState {
  const factory ShippingState(
      {
        @Default([]) List<Order> listFinishedOrders,
        @Default([]) List<Order> listCurrentOrders,
        bool? orderUpdateResult
      }) = _Initial;
}