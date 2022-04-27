// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  }

  final AuthRepository _authRepository;
  late final StreamSubscription _listenToAuthChangesStream;
  late final StreamSubscription _listenToUserChangesStream;

  void _onAppLaunched(
    AppEventAppLaunched event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(userFetchStatus: AppStateUserFetchStatus.loading));
    //todo check if this works with authentication from the other numbers
    _listenToAuthChanges();
    _listenToUserChanges();
  }

  void _onAuthStatusChanged(
    AppAuthStatusChanged event,
    Emitter<AppState> emit,
  ) {
    final status = event.authenticated;
    emit(state.copyWith(authenticated: status));
    _updateUser();
  }

  _listenToUserChanges() {
    _listenToUserChangesStream = _authRepository.getCurrentUserStream().listen((event) {
      if (event is Success<User, String>) {
        emit(state.copyWith(
            currentUser: event.data,
            userFetchStatus: AppStateUserFetchStatus.success));
      } else if (event is Failure<User, String>) {
        emit(state.copyWith(
            userFetchStatus: AppStateUserFetchStatus.failure,
            userFetchingError: event.error));
      }
    });
  }

  _listenToAuthChanges() {
    _listenToAuthChangesStream = _authRepository.authChanges().listen((user) {
      emit(state.copyWith(authenticated: user != null));
      add(AppAuthStatusChanged(user != null));
    });
  }

  _updateUser() async{
    final result = await _authRepository.getCurrentUser();
    if(result is Success<User, String>){
      final prefs = await SharedPreferences.getInstance();
      if(result.data?.address?.region != null) {
        prefs.setString('userRegion', result.data!.address!.region!);
      }
      emit(state.copyWith(currentUser: result.data));
    }
  }

  @override
  Future<void> close() async {
    _listenToUserChangesStream.cancel();
    _listenToAuthChangesStream.cancel();
    super.close();
  }
}
