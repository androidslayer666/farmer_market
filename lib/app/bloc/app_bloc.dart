// ignore_for_file: invalid_use_of_visible_for_testing_member

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
    _authRepository.getCurrentUserStream().listen((user) {
      emit(state.copyWith(currentUser: user));
    });
  }


  final AuthRepository _authRepository;

  void _onAppLaunched(
    AppEventAppLaunched event,
    Emitter<AppState> emit,
  ) async {
    _updateUser();
  }

  void _onAuthStatusChanged(
    AppAuthStatusChanged event,
    Emitter<AppState> emit,
  ) {
    final status = event.authenticated;
    emit(state.copyWith(authenticated: status));
  }

  void _updateUser() async {
    final result = await _authRepository.getCurrentUser();
    final prefs = await SharedPreferences.getInstance();

    if (result is Success<User, String>) {
      if (result.data?.address?.region != null) {
        // will be used in product request for the storage. It's simpler than forwarding through UI.
        prefs.setString('userRegion', result.data!.address!.region!);
      }
      emit(state.copyWith(currentUser: result.data));
    }
  }
}
