

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/shared/utils.dart';

import '../../../../repository/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginPhoneChanged>(_onPhoneChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onPhoneChanged(
      LoginPhoneChanged event,
      Emitter<LoginState> emit,
      ) {
    final phone = event.phone;
    emit(state.copyWith(
        phone: phone,
      phoneIsValid: phone.isValidPhone()
    ));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    final password = event.password;
    emit(state.copyWith(
      password: password,
      passwordIsValid: password.isValidPassword()
    ));
  }

  void _onSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    if (state.passwordIsValid && state.phoneIsValid) {
      emit(state.copyWith(isLoading: true));
      try {
        await _authRepository.loginUser(
          email: state.phone,
          password: state.password,
        );
        emit(state.copyWith(loginStatus: LoginStatus.success));
      } catch (_) {
        emit(state.copyWith(loginStatus: LoginStatus.failure));
      }
    }
  }
}
