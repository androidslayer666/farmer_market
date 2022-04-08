
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:farmer_market/presentation/screens/main_screen_pages/user_products_page/bloc/user_products_state.dart';

import '../../../../../data/models/product/product.dart';
import '../../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../../data/repository/product_repository/product_repository.dart';
import '../../../../../data/repository/success_failure.dart';

part 'user_products_event.dart';

class UserProductsBloc extends Bloc<UserProductsEvent, UserProductsState> {
  UserProductsBloc(
      {required AuthRepository authRepository,
      required ProductRepository productRepository})
      : _authRepository = authRepository,
        _productRepository = productRepository,
        super(const UserProductsState()) {
    on<UserProductsEventInit>(_onInit);
    on<UserProductsEventUpdateList>(_onUpdateList);
  }

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;

  _onInit(
    UserProductsEventInit event,
    Emitter<UserProductsState> emit,
  ) {
    _fetchUserProducts();
  }

  _onUpdateList(
      UserProductsEventUpdateList event,
      Emitter<UserProductsState> emit,
      ){
    _fetchUserProducts();
  }

  _fetchUserProducts() async {
    emit(state.copyWith(isLoading: true));
    final userId = _authRepository.getUserId();
    final productsResult =
        await _productRepository.getUserProducts(userId ?? '');
    if (productsResult is Success<List<Product>, String>) {
      if (productsResult.data != null) {
        emit(state.copyWith(
            listProducts: productsResult.data!, isLoading: false));
      }
    } else if (productsResult is Failure<List<Product>, String>) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
