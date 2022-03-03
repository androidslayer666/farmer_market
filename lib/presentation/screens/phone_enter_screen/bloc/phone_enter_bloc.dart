import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/phone_enter_screen/bloc/phone_enter_event.dart';
import 'package:farmer_market/presentation/screens/phone_enter_screen/bloc/phone_enter_state.dart';
import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../data/repository/success_failure.dart';

class PhoneEnterBloc extends Bloc<PhoneEnterEvent, PhoneEnterStateFreezed> {
  PhoneEnterBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const PhoneEnterStateFreezed()) {
    on<PhoneEnterPhoneChanged>(_onPhoneChanged);
    on<PhoneEnterCodeChanged>(_onCodeChanged);
    on<PhoneEnterSubmitted>(_onPhoneSubmitted);
    on<PhoneCodeSent>(_onPhoneCodeSent);
    on<OnCodeSubmitted>(_onCodeSubmitted);
  }

  final AuthRepository _authRepository;

  void _onPhoneChanged(
    PhoneEnterPhoneChanged event,
    Emitter<PhoneEnterStateFreezed> emit,
  ) {
    final phone = event.phone;
    if (state.phoneIsValid == false) {
      emit(state.copyWith(phone: phone, phoneIsValid: phone.isValidPhone()));
    } else {
      emit(state.copyWith(phone: phone));
    }
  }

  void _onCodeChanged(
    PhoneEnterCodeChanged event,
    Emitter<PhoneEnterStateFreezed> emit,
  ) {
    final code = event.code;
    emit(state.copyWith(code: code));
  }

  void _onPhoneSubmitted(
      PhoneEnterSubmitted event, Emitter<PhoneEnterStateFreezed> emit) async {
    if (state.phone != null) {
      emit(state.copyWith(phoneIsValid: state.phone!.isValidPhone()));
    }
    if (state.phoneIsValid == true) {
      emit(state.copyWith(isLoading: true));
      try {
        await _authRepository.signUpWithPhone(
          // the instance is needed to add an event of sending code
          bloc: this,
          phone: state.phone ?? '',
        );
      } catch (_) {
        emit(state.copyWith(
            loginStatus: PhoneLoginStatus.failure, isLoading: false));
      }
    }
  }

  void _onPhoneCodeSent(
      PhoneCodeSent event, Emitter<PhoneEnterStateFreezed> emit) {
    emit(state.copyWith(
        onCodeConfirmedDo: event.onCodeSubmitted,
        codeIsSent: true,
        isLoading: false));
  }

  void _onCodeSubmitted(
      OnCodeSubmitted event, Emitter<PhoneEnterStateFreezed> emit) async {
    if (state.code != null) {
      emit(state.copyWith(codeIsValid: state.code!.isValidCode()));
      if (state.onCodeConfirmedDo != null && state.code!.isValidCode()) {
        emit(state.copyWith(isLoading: true));
        final result = await state.onCodeConfirmedDo!(state.code!);
        final haveCurrentUserName =
            await _authRepository.getCurrentUser() is Success;
        if (result is firebase.UserCredential) {
          //print('haveCurrentUserName' + _authRepository.haveCurrentUserName().toString());
          emit(state.copyWith(
              isLoading: false,
              loginStatus: PhoneLoginStatus.success,
              haveUserInfoOnServer: haveCurrentUserName));
        } else {
          emit(state.copyWith(
              isLoading: false,
              loginStatus: PhoneLoginStatus.failure,
              haveUserInfoOnServer: haveCurrentUserName));
        }
      }
    }
  }
}
