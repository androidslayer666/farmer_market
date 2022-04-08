import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/models/cart/cart.dart';
import '../../../../../data/models/cart/cart_item.dart';
import '../../../../../data/models/product/product.dart';
import '../../../../../data/models/user/user.dart';
import '../../../../../data/repository/cart_repository/cart_repository.dart';
import '../../../../../data/repository/success_failure.dart';
import 'cart_state.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(
    CartRepository cartRepository,
  )   : _cartRepository = cartRepository,
        super(const CartState()) {

    on<CartEventAddToCart>(_onAddToCart);
    on<CartEventRemoveFromCart>(_onRemoveFromCart);
    on<CartEventInit>(_onInit);
    on<CartEventCreateOrderClicked>(_onCreateOrderClicked);
  }

  final CartRepository _cartRepository;

  _onInit(
      CartEventInit event, Emitter<CartState> emit
      ) async {
    final cartResult = await _cartRepository.getCart();
    if (cartResult is Success<Cart, String>) {
      emit(state.copyWith(cart: cartResult.data ?? const Cart()));
    }
  }

  void _onAddToCart(CartEventAddToCart event, Emitter<CartState> emit) async {
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

  void _onRemoveFromCart(
      CartEventRemoveFromCart event, Emitter<CartState> emit) {
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

  _onCreateOrderClicked(
      CartEventCreateOrderClicked event, Emitter<CartState> emit
      ){
    final cartItems = [...state.cart.cartItems]
        .where((element) => element.user?.id != event.user?.id)
        .toList();
    emit(state.copyWith(cart: state.cart.copyWith(cartItems: cartItems)));
    _cartRepository.saveCart(cart: state.cart);
  }
}
