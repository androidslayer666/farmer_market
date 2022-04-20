// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';

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
      : _authRepository = authRepository,
        super(AppState(authenticated: authenticated)) {
    on<AppAuthStatusChanged>(_onAuthStatusChanged);
    on<AppEventAppLaunched>(_onAppLaunched);
    _authRepository.getCurrentUserStream().listen((result) {
      if(result is Success<User, String>) {
        emit(state.copyWith(currentUser: result.data));
      }
    });
  }


  final AuthRepository _authRepository;

  void _onAppLaunched(
    AppEventAppLaunched event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(userFetchStatus: AppStateUserFetchStatus.loading));
    _listenToUserChanges();
  }

  void _onAuthStatusChanged(
    AppAuthStatusChanged event,
    Emitter<AppState> emit,
  ) {
    final status = event.authenticated;
    emit(state.copyWith(authenticated: status));
  }

  _listenToUserChanges(){
    _authRepository.getCurrentUserStream().listen((event) {
      if(event is Success<User, String>){
        emit(state.copyWith(currentUser: event.data, userFetchStatus: AppStateUserFetchStatus.success));
      } else if (event is Failure<User, String>){
        emit(state.copyWith(userFetchStatus: AppStateUserFetchStatus.failure, userFetchingError: event.error));
      }
    });
  }

}
