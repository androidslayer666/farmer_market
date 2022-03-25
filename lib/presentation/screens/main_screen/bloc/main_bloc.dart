// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:farmer_market/data/repository/cart_repository/cart_repository.dart';
import 'package:farmer_market/data/repository/success_failure.dart';

import '../../../../data/models/cart/cart_item.dart';
import '../../../../data/models/product/product.dart';
import '../../../../data/models/user/user.dart';
import '../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../data/repository/product_repository/product_repository.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(
      {required AuthRepository authRepository,
      required ProductRepository productRepository,
      required CartRepository cartRepository})
      : _authRepository = authRepository,
        _productRepository = productRepository,
        _cartRepository = cartRepository,
        super(const MainState()) {
    on<MainScreenInit>(_mainScreenInit);
    on<MainScreenUpdateListProductRequested>(_onUpdateListProductRequested);
    on<MainScreenTabChanged>(_onTabChanged);
    on<MainScreenBackButtonPressedWhenStackIsClear>(
        _backButtonPressedWhenStackIsClear);
    on<MainScreenBackButtonPressed>(_onBackButtonPressed);
    on<MainScreenAddToCart>(_onAddToCart);
    on<MainScreenRemoveFromCart>(_onRemoveFromCart);
    on<MainScreenFilterToggled>(_onFilterToggled);
    on<MainScreenFilterChanged>(_onFilterChanged);
  }

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;
  final CartRepository _cartRepository;

  void _mainScreenInit(MainScreenInit event, Emitter<MainState> emit) async {
    //print('_mainScreenInit');
    _refreshListProducts();
    _fetchUserProducts();
  }

  void _onUpdateListProductRequested(MainScreenUpdateListProductRequested event,
      Emitter<MainState> emit) async {
    //print('_onUpdateListProductRequested');
    _refreshListProducts();
  }

  void _onTabChanged(MainScreenTabChanged event, Emitter<MainState> emit) {
    if(event.tabIndex != state.pageStack.last) {
      final pageStack = [...state.pageStack, event.tabIndex];
      if (pageStack.length > 3) {
        pageStack.removeAt(0);
      }
      emit(state.copyWith(
          pageStack: pageStack, backButtonPressedWhenStackIsClear: false));
    }
  }

  void _onBackButtonPressed(
      MainScreenBackButtonPressed event, Emitter<MainState> emit) {
    final pageStack = [...state.pageStack];
    if (pageStack.length > 1) {
      pageStack.removeLast();
    }
    emit(state.copyWith(pageStack: pageStack));
  }

  void _backButtonPressedWhenStackIsClear(
      MainScreenBackButtonPressedWhenStackIsClear event,
      Emitter<MainState> emit) {
    emit(state.copyWith(backButtonPressedWhenStackIsClear: true));
  }

  void _onFilterChanged(
      MainScreenFilterChanged event,
      Emitter<MainState> emit
      ){
    emit(state.copyWith(filter: event.filter));
  }

  void _onAddToCart(MainScreenAddToCart event, Emitter<MainState> emit) async {
    final listProducts = state.cart.cartItems.map((e) => e.product).toList();
    if (!listProducts.contains(event.product)) {
      emit(state.copyWith(
          cart: state.cart.copyWith(cartItems: [
        ...state.cart.cartItems,
        CartItem(product: event.product, qty: 1)
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

  void _onFilterToggled(
      MainScreenFilterToggled event, Emitter<MainState> emit
      ){
    emit(state.copyWith(filterSwitchedOn: !state.filterSwitchedOn));
  }

  void _onRemoveFromCart(
      MainScreenRemoveFromCart event, Emitter<MainState> emit) {
    final listProducts = state.cart.cartItems.map((e) => e.product).toList();
    if (listProducts.contains(event.product)) {
      final index = listProducts.indexOf(event.product);
      final cartItem = state.cart.cartItems[index];
      final items = [...state.cart.cartItems];
      if (items[index].qty > 1) {
        items.removeAt(index);
        items.insert(index, cartItem.copyWith(qty: (cartItem.qty) - 1));
        emit(state.copyWith(cart: state.cart.copyWith(cartItems: [...items])));
        //print(state.cart.cartItems);
      } else {
        items.removeAt(index);
        emit(state.copyWith(cart: state.cart.copyWith(cartItems: items)));
        //print(state.cart.cartItems);
      }
      _cartRepository.saveCart(cart: state.cart);
    }
  }

  void _refreshListProducts() async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.getCurrentUser();
    if (result is Success<User, String>) {
      emit(state.copyWith(user: result.data));
    } else if (result is Failure<User, String>) {
      emit(state.copyWith(errorWhileFetchingProducts: result.error));
    }
    final productsResult = await _productRepository.getAllProducts(state.filter);
    if (productsResult is Success<List<Product>, String>) {
      if (productsResult.data != null) {
        emit(state.copyWith(
            listProducts: productsResult.data!, isLoading: false));
      }
    } else if (productsResult is Failure<List<Product>, String>) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _fetchUserProducts() async {
    emit(state.copyWith(isLoading: true));
    final userId = _authRepository.getUserId();
    final productsResult = await _productRepository.getUserProducts(userId ?? '');
    if (productsResult is Success<List<Product>, String>) {
      if (productsResult.data != null) {
        emit(state.copyWith(
            listUserProducts: productsResult.data!, isLoading: false));
      }
    } else if (productsResult is Failure<List<Product>, String>) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
