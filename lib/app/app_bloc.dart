
import 'package:farmer_market/repository/auth_repository/auth_repository.dart';
import 'package:farmer_market/repository/success_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bloc/bloc.dart';

import '../presentation/di/getit_setup.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(bool authenticated) : super(AppState(authenticated: authenticated)) {
    on<AppAuthStatusChanged>(_onAuthStatusChanged);
  }

  void _onAuthStatusChanged(
      AppAuthStatusChanged event,
      Emitter<AppState> emit,
      ) {
    print('on status Changed, status : ${event.authenticated}');
    final status = event.authenticated;
    emit(state.copyWith(authenticated: status));
  }

}