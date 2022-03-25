// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/cart/cart.dart';
import '../../data/models/cart/cart_item.dart';
import '../../data/models/order/order.dart';
import '../../data/models/user/user.dart';
import '../../data/repository/auth_repository/auth_repository.dart';
import '../../data/repository/cart_repository/cart_repository.dart';
import '../../data/repository/order_repository/order_repository.dart';
import '../../data/repository/success_failure.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(bool authenticated, CartRepository cartRepository,
      OrderRepository orderRepository, AuthRepository authRepository)
      : _cartRepository = cartRepository,
        _orderRepository = orderRepository,
        _authRepository = authRepository,
        super(AppState(authenticated: authenticated)) {
    on<AppAuthStatusChanged>(_onAuthStatusChanged);
    on<AppStateAddToCart>(_onAddToCart);
    on<AppStateRemoveFromCart>(_onRemoveFromCart);
    on<AppEventAppLaunched>(_onAppLaunched);
    on<AppStateCreateOrderClicked>(_onCreateOrderClicked);
    on<AppStateConfirmDateShipping>(_onConfirmDateShipping);
  }

  final CartRepository _cartRepository;
  final OrderRepository _orderRepository;
  final AuthRepository _authRepository;

  void _onAppLaunched(
    AppEventAppLaunched event,
    Emitter<AppState> emit,
  ) {
    _fetchCart();
    _fetchOrders();
    _updateUser();
  }

  void _onAuthStatusChanged(
    AppAuthStatusChanged event,

    Emitter<AppState> emit,
  ) {
    final status = event.authenticated;
    emit(state.copyWith(authenticated: status));
  }

  void _onAddToCart(AppStateAddToCart event, Emitter<AppState> emit) async {
    final listProducts = state.cart.cartItems.map((e) => e.product).toList();
    if (!listProducts.contains(event.product)) {
      emit(state.copyWith(
          cart: state.cart.copyWith(cartItems: [
        ...state.cart.cartItems,
        CartItem(product: event.product, qty: 1, user: event.user)
      ])));
    } else {
      final index = listProducts.indexOf(event.product);
      final cartItem = state.cart.cartItems[index];
      final items = [...state.cart.cartItems];
      items.removeAt(index);
      items.insert(index, cartItem.copyWith(qty: (cartItem.qty) + 1));
      emit(state.copyWith(cart: state.cart.copyWith(cartItems: [...items])));
      await _cartRepository.saveCart(cart: state.cart);
    }
  }

  void _onRemoveFromCart(AppStateRemoveFromCart event, Emitter<AppState> emit) {
    final listProducts = state.cart.cartItems.map((e) => e.product).toList();
    if (listProducts.contains(event.product)) {
      final index = listProducts.indexOf(event.product);
      final cartItem = state.cart.cartItems[index];
      final items = [...state.cart.cartItems];
      if (items[index].qty > 1) {
        items.removeAt(index);
        items.insert(index, cartItem.copyWith(qty: (cartItem.qty) - 1));
        emit(state.copyWith(cart: state.cart.copyWith(cartItems: [...items])));
      } else {
        items.removeAt(index);
        emit(state.copyWith(cart: state.cart.copyWith(cartItems: items)));
      }
      _cartRepository.saveCart(cart: state.cart);
    }
  }

  void _onConfirmDateShipping  (
      AppStateConfirmDateShipping event, Emitter<AppState> emit
      ) async {
    final updatedOrder = event.order.copyWith(confirmedShippingDate: event.dateTime);
    final result = await _orderRepository.saveOrder(order: updatedOrder);
    emit(state.copyWith(orderUpdateResult: result is Success));
    _fetchOrders();
  }

  void _fetchCart() async {
    final cartResult = await _cartRepository.getCart();
    if (cartResult is Success<Cart, String>) {
      emit(state.copyWith(cart: cartResult.data ?? const Cart()));
    }
  }

  void _fetchOrders() async {
    final orderResult = await _orderRepository.getOrders();
    if (orderResult is Success<List<Order>, String>) {
      emit(state.copyWith(
          listOrders:
              (orderResult).data ?? []));
    }
  }

  void _onCreateOrderClicked(
    AppStateCreateOrderClicked event,
    Emitter<AppState> emit,
  ) {
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
    final cartItems = [...state.cart.cartItems]
        .where((element) => element.user?.id != event.user.id)
        .toList();
    emit(state.copyWith(cart: state.cart.copyWith(cartItems: cartItems)));
    _cartRepository.saveCart(cart: state.cart);
  }

  void _updateUser() async{
    final result  = await _authRepository.getCurrentUser();
    if(result is Success<User, String>){
      emit(state.copyWith(currentUser: result.data));
    }
  }

}
