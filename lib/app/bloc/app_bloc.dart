
import 'package:bloc/bloc.dart';

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