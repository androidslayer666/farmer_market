import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/signin_screen/bloc/sigin_event.dart';
import 'package:farmer_market/presentation/screens/signin_screen/bloc/signin_state.dart';
import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../repository/auth_repository.dart';
import '../../login/bloc/login_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const SignInState()) {
    on<SignInNameChanged>(_onNameChanged);
    on<SignInPhoneChanged>(_onPhoneChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInImageAddClicked>(_onImageChanged);
    on<SignInSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onNameChanged(
    SignInNameChanged event,
    Emitter<SignInState> emit,
  ) {
    final name = event.name;
    emit(state.copyWith(name: name));
  }

  void _onPhoneChanged(
    SignInPhoneChanged event,
    Emitter<SignInState> emit,
  ) {
    final phone = event.phone;
    emit(state.copyWith(phone: phone, phoneIsValid: phone.isValidPhone()));
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final password = event.password;
    emit(state.copyWith(
        password: password, passwordIsValid: password.isValidPassword()));
  }

  void _onImageChanged(
      SignInImageAddClicked event,
      Emitter<SignInState> emit,
      ) async {
    Uint8List im = await pickImage(ImageSource.gallery);
    emit(state.copyWith(image: im));
  }

  void _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    if (state.passwordIsValid && state.phoneIsValid) {
      emit(state.copyWith(isLoading: true));
      try {
        await _authRepository.signUpUser(
          name: state.name,
          email: state.phone,
          password: state.password,
          isSeller: false,
        );
        emit(state.copyWith(signInStatus: SignInStatus.success));
      } catch (_) {
        emit(state.copyWith(signInStatus: SignInStatus.failure));
      }
    }
  }
}
