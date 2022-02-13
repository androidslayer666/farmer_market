import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_state.dart';

import '../../../../repository/auth_repository/auth_repository.dart';
import '../../phone_enter_screen/bloc/phone_enter_state.dart';
import 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const MainState()) {
    on<MainScreenInit>(_mainScreenInit);
  }

  final AuthRepository _authRepository;

  void _mainScreenInit(MainScreenInit event, Emitter<MainState> emit) async {
    final user = await _authRepository.getCurrentUser();
    emit(state.copyWith(user: user));
  }
}
