import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_state.dart';
import 'package:farmer_market/repository/success_failure.dart';

import '../../../../repository/auth_repository/auth_repository.dart';
import '../../../../repository/models/product/product.dart';
import '../../../../repository/models/user/user.dart';
import '../../../../repository/products/product_repository.dart';
import 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required AuthRepository authRepository,
    required ProductRepository productRepository,
  })  : _authRepository = authRepository,
        _productRepository = productRepository,
        super(const MainState()) {
    on<MainScreenInit>(_mainScreenInit);
    on<UpdateListProductRequested>(_onUpdateListProductRequested);
  }

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;

  void _mainScreenInit(MainScreenInit event, Emitter<MainState> emit) async {
    print('_mainScreenInit');
    _refreshListProducts();
  }

  void _onUpdateListProductRequested(
      UpdateListProductRequested event, Emitter<MainState> emit) async {
    print('_onUpdateListProductRequested');
    _refreshListProducts();
  }

  void _refreshListProducts() async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.getCurrentUser();
    if (result is Success<User, String>) {
      emit(state.copyWith(user: result.data));
    } else if (result is Failure<User, String>) {
      emit(state.copyWith(errorWhileFetchingProducts: result.error));
    }
    final productsResult = await _productRepository.getAllProducts();
    if (productsResult is Success<List<Product>, String>) {
      if (productsResult.data!= null) {
        emit(state.copyWith(listProducts: productsResult.data!, isLoading: false));
      }
    } else if (productsResult is Failure<List<Product>, String>) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
