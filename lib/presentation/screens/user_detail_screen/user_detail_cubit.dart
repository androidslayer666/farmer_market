import 'package:bloc/bloc.dart';
import 'package:farmer_market/data/repository/product_repository/product_repository.dart';
import 'package:farmer_market/data/repository/user_repository/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/product/product.dart';
import '../../../data/models/user/user.dart';
import '../../../data/repository/success_failure.dart';

part 'user_detail_cubit.freezed.dart';

@freezed
class UserDetailState with _$UserDetailState {
  const factory UserDetailState(
      {bool? sendMessageIsClicked,
      User? user,
      List<Product>? listProducts}) = _Initial;
}

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit(
      UserRepository userRepository, ProductRepository productRepository)
      : _userRepository = userRepository,
        _productRepository = productRepository,
        super(const UserDetailState());

  final ProductRepository _productRepository;
  final UserRepository _userRepository;

  void sendMessageIsClicked() {
    emit(state.copyWith(sendMessageIsClicked: true));
  }

  void onInit(String? userId) async {
    if (userId != null) {
      final resultUser = await _userRepository.getUserById(userId);
      final resultProducts = await _productRepository.getUserProducts(userId);
      if (resultUser is Success<User, String>) {
        emit(state.copyWith(user: resultUser.data));
        if (resultProducts is Success<List<Product>, String>) {
          emit(state.copyWith(listProducts: resultProducts.data));
        }
      }
    }
  }
}
