import 'package:bloc/bloc.dart';
import 'package:farmer_market/data/repository/success_failure.dart';
import 'package:farmer_market/data/repository/user_repository/user_repository.dart';
import 'package:farmer_market/presentation/screens/product_detail_screen/bloc/product_detail_screen_event.dart';
import 'package:farmer_market/presentation/screens/product_detail_screen/bloc/product_detail_screen_state.dart';

import '../../../../data/models/user/user.dart' as models;

class ProductDetailScreenBloc
    extends Bloc<ProductDetailScreenEvent, ProductDetailScreenState> {
  final UserRepository _userRepository;

  ProductDetailScreenBloc(
      ProductDetailScreenState initialState, UserRepository userRepository)
      : _userRepository = userRepository,
        super(initialState) {
    on<ProductDetailScreenOnInit>(_productDetailScreenOnInit);
  }

  _productDetailScreenOnInit(
    ProductDetailScreenOnInit event,
    Emitter<ProductDetailScreenState> emit,
  ) async {
    final result = await _userRepository.getUserById(event.userId);
    if (result is Success<models.User, String>) {
      emit(state.copyWith(user: result.data));
    } else {
      emit(state.copyWith(problemWithFetchingUser: true));
    }
  }
}
