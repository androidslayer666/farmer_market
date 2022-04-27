import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/authorization_screen/bloc/authorization_event.dart';
import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../data/repository/success_failure.dart';
import '../../authorization_screen/bloc/authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthorizationState()) {
    on<AuthorizationPhoneChanged>(_onPhoneChanged);
    on<AuthorizationCodeChanged>(_onCodeChanged);
    on<AuthorizationPhoneSubmitted>(_onPhoneSubmitted);
    on<AuthorizationCodeSent>(_onPhoneCodeSent);
    on<AuthorizationCodeSubmitted>(_onCodeSubmitted);
    on<AuthorizationResetState>(_onResetState);
    on<AuthorizationTimerIsOver>(_onTimerIsOver);
  }

  final AuthRepository _authRepository;

  _onPhoneChanged(
    AuthorizationPhoneChanged event,
    Emitter<AuthorizationState> emit,
  ) {
    final phone = event.phone;
    if (state.phoneIsValid == false) {
      emit(state.copyWith(phone: phone, phoneIsValid: phone.isValidPhone()));
    } else {
      emit(state.copyWith(phone: phone));
    }
  }

  _onResetState(
      AuthorizationResetState event,
      Emitter<AuthorizationState> emit,
      ) {
    emit(state.copyWith(
        loginStatus: PhoneLoginStatus.unknown,
        code: '',
        codeIsValid: null,
        phoneIsValid: null));
  }

  _onCodeChanged(
    AuthorizationCodeChanged event,
    Emitter<AuthorizationState> emit,
  ) {
    final code = event.code;
    emit(state.copyWith(code: code));
  }

  _onPhoneSubmitted(AuthorizationPhoneSubmitted event,
      Emitter<AuthorizationState> emit) async {
    if (state.phone != null) {
      emit(state.copyWith(phoneIsValid: state.phone!.isValidPhone()));
    }
    if (state.phoneIsValid == true) {
      emit(state.copyWith(loginStatus: PhoneLoginStatus.awaitingCode, timerIsSet: true));
      try {
        await _authRepository.signUpWithPhone(
          // the instance is needed to add an event of sending code
          bloc: this,
          phone: state.phone ?? '',
        );
      } catch (_) {
        emit(state.copyWith(loginStatus: PhoneLoginStatus.failure));
      }
    }
  }

  _onPhoneCodeSent(
      AuthorizationCodeSent event, Emitter<AuthorizationState> emit) {
    emit(state.copyWith(
        onCodeConfirmedDo: event.onCodeSubmitted,
        loginStatus: PhoneLoginStatus.codeIsSent));
  }

  _onCodeSubmitted(AuthorizationCodeSubmitted event,
      Emitter<AuthorizationState> emit) async {
    if (state.code != null) {
      emit(state.copyWith(codeIsValid: state.code!.isValidCode()));
      if (state.onCodeConfirmedDo != null && state.code!.isValidCode()) {
        emit(state.copyWith(loginStatus: PhoneLoginStatus.codeSubmitted));
        final result = await state.onCodeConfirmedDo!(state.code!);
        final haveCurrentUserName =
            await _authRepository.getCurrentUser() is Success;
        if (result is firebase.UserCredential) {
          //print('haveCurrentUserName' + _authRepository.haveCurrentUserName().toString());
          emit(state.copyWith(
              loginStatus: PhoneLoginStatus.success,
              haveUserInfoOnServer: haveCurrentUserName));
        } else {
          emit(state.copyWith(
              loginStatus: PhoneLoginStatus.failure,
              haveUserInfoOnServer: haveCurrentUserName));
        }
      }
    }
  }

  _onTimerIsOver(
      AuthorizationTimerIsOver event,
      Emitter<AuthorizationState> emit
      ){
    emit(state.copyWith(timerIsSet: false));
  }
}
