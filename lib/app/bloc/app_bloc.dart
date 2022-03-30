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
    on<AppEventAppLaunched>(_onAppLaunched);
  }

  final CartRepository _cartRepository;
  final OrderRepository _orderRepository;
  final AuthRepository _authRepository;

  void _onAppLaunched(
    AppEventAppLaunched event,
    Emitter<AppState> emit,
  ) {
    _updateUser();
  }

  void _onAuthStatusChanged(
    AppAuthStatusChanged event,
    Emitter<AppState> emit,
  ) {
    final status = event.authenticated;
    emit(state.copyWith(authenticated: status));
  }


  void _updateUser() async{
    final result  = await _authRepository.getCurrentUser();
    if(result is Success<User, String>){
      emit(state.copyWith(currentUser: result.data));
    }
  }

}
