import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:equatable/equatable.dart';

import '../../data/models/cart/cart.dart';
import '../../data/models/order/order.dart';
import '../../data/models/user/user.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState(
      {
        @Default(false) bool authenticated,
        @Default(Cart()) Cart cart,
        @Default([]) List<Order> listOrders,
        User? currentUser,
        bool? orderUpdateResult
      }) = _Initial;
}