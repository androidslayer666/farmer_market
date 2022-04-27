// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../data/models/cart/cart_item.dart';
import '../../../../../../data/models/order/order.dart';
import '../../../../../../data/models/user/user.dart';
import '../../../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../../../data/repository/cart_repository/cart_repository.dart';
import '../../../../../../data/repository/order_repository/order_repository.dart';
import '../../../../../../data/repository/success_failure.dart';
import 'shipping_state.dart';

part 'shipping_event.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final OrderRepository _orderRepository;
  final AuthRepository _authRepository;

  ShippingBloc(
      {required CartRepository cartRepository,
      required OrderRepository orderRepository,
      required AuthRepository authRepository})
      : _orderRepository = orderRepository,
        _authRepository = authRepository,
        super(const ShippingState()) {
    on<ShippingEventInit>(_onInit);
    on<ShippingEventCreateOrderClicked>(_onCreateOrderClicked);
    on<ShippingEventConfirmDateShipping>(_ontConfirmDateShipping);
  }

  _onInit(ShippingEventInit event, Emitter<ShippingState> emit) {
    _fetchOrders();
  }

  _onCreateOrderClicked(
      ShippingEventCreateOrderClicked event, Emitter<ShippingState> emit) {
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
  }

  _ontConfirmDateShipping(ShippingEventConfirmDateShipping event,
      Emitter<ShippingState> emit) async {
    final updatedOrder =
        event.order.copyWith(confirmedShippingDate: event.dateTime);
    final result = await _orderRepository.saveOrder(order: updatedOrder);
    emit(state.copyWith(orderUpdateResult: result is Success));
    _fetchOrders();
  }

  void _fetchOrders() async {
    final orderResult = await _orderRepository.getOrders();


    if (orderResult is Success<List<Order>, String>) {
      final listFinishedOrders = orderResult.data
          ?.where((element) =>
      element.confirmedShippingDate != null &&
          DateTime.now().isAfter(element.confirmedShippingDate!))
          .toList();
      final listCurrentOrders = orderResult.data
          ?.where((element) => element.confirmedShippingDate == null || element.confirmedShippingDate != null &&
          DateTime.now().isBefore(element.confirmedShippingDate!))
          .toList();

      emit(state.copyWith(
          listCurrentOrders: listCurrentOrders ?? [],
          listFinishedOrders: listFinishedOrders ?? []));
    }
  }
}
