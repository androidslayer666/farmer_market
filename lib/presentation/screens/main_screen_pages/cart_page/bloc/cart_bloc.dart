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
    on<CartEventAddedSuccessfully>(_onAddedSuccessfully);
    on<CartEventCreateOrderClicked>(_onCreateOrderClicked);
  }

  final CartRepository _cartRepository;

  _onInit(
      CartEventInit event, Emitter<CartState> emit
      ) async {
    final cartResult = await _cartRepository.getCart();
    if (cartResult is Success<Cart, String>) {
      emit(state.copyWith(cart: cartResult.data ?? const Cart(),successfullyAddedToCart: null));
    }
  }

  void _onAddToCart(CartEventAddToCart event, Emitter<CartState> emit) async {
    final listProducts = state.cart.cartItems.map((e) => e.product).toList();
    if (!listProducts.contains(event.product)) {
      emit(state.copyWith(
          cart: state.cart.copyWith(cartItems: [
        ...state.cart.cartItems,
        CartItem(product: event.product, qty: 1, user: event.user)
      ]),successfullyAddedToCart: null));
      final result = await _cartRepository.saveCart(cart: state.cart);
      if(result is Success){
        emit(state.copyWith(successfullyAddedToCart: true));
      }else {
        emit(state.copyWith(successfullyAddedToCart: false));
      }
    } else {
      final index = listProducts.indexOf(event.product);
      final cartItem = state.cart.cartItems[index];
      final items = [...state.cart.cartItems];
      items.removeAt(index);
      items.insert(index, cartItem.copyWith(qty: (cartItem.qty) + 1));
      emit(state.copyWith(cart: state.cart.copyWith(cartItems: [...items]),successfullyAddedToCart: null));
      final result = await _cartRepository.saveCart(cart: state.cart);
      if(result is Success){
        emit(state.copyWith(successfullyAddedToCart: true));
      } else {
        if(event.product != null) {
          add(CartEventRemoveFromCart(event.product!));
        }
        emit(state.copyWith(successfullyAddedToCart: false));
      }
    }
  }

  void _onRemoveFromCart(
      CartEventRemoveFromCart event, Emitter<CartState> emit) async {
    final listProducts = state.cart.cartItems.map((e) => e.product).toList();
    if (listProducts.contains(event.product)) {
      final index = listProducts.indexOf(event.product);
      final cartItem = state.cart.cartItems[index];
      final user = state.cart.cartItems[index].user;
      final items = [...state.cart.cartItems];
      if (items[index].qty > 1) {
        items.removeAt(index);
        items.insert(index, cartItem.copyWith(qty: (cartItem.qty) - 1));
        emit(state.copyWith(cart: state.cart.copyWith(cartItems: [...items]),successfullyAddedToCart: null));
      } else {
        items.removeAt(index);
        emit(state.copyWith(cart: state.cart.copyWith(cartItems: items),successfullyAddedToCart: null));
      }
      final result = await _cartRepository.saveCart(cart: state.cart);
      if(result is Success){
        emit(state.copyWith(successfullyAddedToCart: true));
      } else {
        add(CartEventAddToCart(event.product, user));
        emit(state.copyWith(successfullyAddedToCart: false));
      }
    }
  }

  _onAddedSuccessfully(
      CartEventAddedSuccessfully event, Emitter<CartState> emit
      ){
    emit(state.copyWith(successfullyAddedToCart: true));
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
