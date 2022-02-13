
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bloc/bloc.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(Stream<User?> stream) : super(const AppState()) {
    on<AppAuthStatusChanged>(_onStatusChanged);
    stream.listen((user) {
      if(user != null) {
        add(const AppAuthStatusChanged(AuthenticationStatus.authenticated));
      }
    });
  }
  void _onStatusChanged(
      AppAuthStatusChanged event,
      Emitter<AppState> emit,
      ) {
    final status = event.status;
    emit(state.copyWith(authenticationStatus: status));
  }

}