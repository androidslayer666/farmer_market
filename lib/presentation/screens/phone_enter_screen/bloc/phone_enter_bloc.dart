

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/phone_enter_screen/bloc/phone_enter_event.dart';
import 'package:farmer_market/presentation/screens/phone_enter_screen/bloc/phone_enter_state.dart';
import 'package:farmer_market/presentation/shared/utils.dart';

import '../../../../repository/auth_repository/auth_repository.dart';


class PhoneEnterBloc extends Bloc<PhoneEnterEvent, PhoneEnterState> {
  PhoneEnterBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const PhoneEnterState()) {
    on<PhoneEnterPhoneChanged>(_onPhoneChanged);
    on<PhoneEnterCodeChanged>(_onCodeChanged);
    on<PhoneEnterSubmitted>(_onPhoneSubmitted);
    on<PhoneCodeSent>(_onPhoneCodeSent);
    on<OnCodeSubmitted>(_onCodeSubmitted);
  }

  final AuthRepository _authRepository;

  void _onPhoneChanged(
      PhoneEnterPhoneChanged event,
      Emitter<PhoneEnterState> emit,
      ) {
    final phone = event.phone;
    emit(state.copyWith(
        phone: phone,
        phoneIsValid: phone.isValidPhone()
    ));
  }

  void _onCodeChanged(
      PhoneEnterCodeChanged event,
      Emitter<PhoneEnterState> emit,
      ) {
    final code = event.code;
    emit(state.copyWith(
        code: code,
        codeIsValid: code.isValidCode()
    ));
  }

  void _onPhoneSubmitted(
      PhoneEnterSubmitted event,
      Emitter<PhoneEnterState> emit
      ) async {
    print('phone enter submitted');
    // todo: confirm the phone
    if (true) {
      emit(state.copyWith(isLoading: true));
      try {
        await _authRepository.signUpWithPhone( context: event.context, phone: state.phone,);

        emit(state.copyWith(loginStatus: PhoneEnterStatus.success, isLoading: false));
      } catch (_) {
        emit(state.copyWith(loginStatus: PhoneEnterStatus.failure, isLoading: false));
      }
    }
  }

  void _onPhoneCodeSent(
      PhoneCodeSent event,
      Emitter<PhoneEnterState> emit
      ){
    print('phone code sent');
    emit(state.copyWith(onCodeConfirmedDo: event.onCodeSubmitted, codeIsSent: true));
  }

  void _onCodeSubmitted(
      OnCodeSubmitted event,
      Emitter<PhoneEnterState> emit
      ) {
    print('code submitted');
    if(state.onCodeConfirmedDo != null && state.code.isValidCode()){
      state.onCodeConfirmedDo!(state.code);
    }

  }

}


