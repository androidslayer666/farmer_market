import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../../data/models/cart/cart.dart';
import '../../../../../data/models/cart/cart_item.dart';
import '../../../../../data/models/order/order.dart';
import '../../../../../data/models/user/user.dart';
import '../../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../../data/repository/cart_repository/cart_repository.dart';
import '../../../../../data/repository/order_repository/order_repository.dart';
import '../../../../../data/repository/success_failure.dart';
import 'shipping_state.dart';

part 'shipping_event.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final OrderRepository _orderRepository;
  final CartRepository _cartRepository;
  final AuthRepository _authRepository;

  ShippingBloc({required   CartRepository cartRepository,
    required OrderRepository orderRepository, required AuthRepository authRepository
  }) :
        _orderRepository = orderRepository,
        _authRepository = authRepository,
        _cartRepository = cartRepository,
        super(const ShippingState()) {
    on<ShippingEventInit>(_onInit);
    on<ShippingEventCreateOrderClicked>(_onCreateOrderClicked);
    on<ShippingEventConfirmDateShipping>(_ontConfirmDateShipping);
  }

  _onInit(
      ShippingEventInit event,
      Emitter<ShippingState> emit
      ){
    _fetchOrders();
  }

  _onCreateOrderClicked(
      ShippingEventCreateOrderClicked event,
      Emitter<ShippingState> emit
      ){
    final order = Order(
        purchaserId: event.user.id,
        shipperId: event.shipperId,
        cartItems: event.listCartItems,
        id: const Uuid().v1(),
        dateCreated: DateTime.now());
    final updatedUser =
    event.user.copyWith(orders: [...?event.user.orders, order.id!]);
    _authRepository.addUserInfo(updatedUser, null);
    _orderRepository.saveOrder(order: order);
    _fetchOrders();
    // todo:
    // final cartItems = [...state.cart.cartItems]
    //     .where((element) => element.user?.id != event.user.id)
    //     .toList();
    // emit(state.copyWith(cart: state.cart.copyWith(cartItems: cartItems)));
    // _cartRepository.saveCart(cart: state.cart);
  }

  _ontConfirmDateShipping(
      ShippingEventConfirmDateShipping event,
      Emitter<ShippingState> emit
      ) async {
    final updatedOrder = event.order.copyWith(confirmedShippingDate: event.dateTime);
    final result = await _orderRepository.saveOrder(order: updatedOrder);
    emit(state.copyWith(orderUpdateResult: result is Success));
    _fetchOrders();
  }

  void _fetchOrders() async {
    final orderResult = await _orderRepository.getOrders();
    if (orderResult is Success<List<Order>, String>) {
      emit(state.copyWith(
          listOrders:
          (orderResult).data ?? []));
    }
  }

}


