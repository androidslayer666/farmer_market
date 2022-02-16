import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_state.dart';
import 'package:farmer_market/repository/success_failure.dart';

import '../../../../repository/auth_repository/auth_repository.dart';
import '../../../../repository/models/user.dart';
import 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const MainState()) {
    on<MainScreenInit>(_mainScreenInit);
    on<MainScreenEditProfileClicked>(_mainScreenEditProfileClicked);
  }

  final AuthRepository _authRepository;

  void _mainScreenInit(MainScreenInit event, Emitter<MainState> emit) async {
    print('_mainScreenInit');
    final result = await _authRepository.getCurrentUser();
    if(result is Success<User>) {
      emit(state.copyWith(user: result.data));
    } else {
      //todo: emit error
    }
  }

  void _mainScreenEditProfileClicked(
      MainScreenEditProfileClicked event, Emitter<MainState> emit
      ){
    print('_mainScreenEditProfileClicked');
    emit(state.copyWith(mainScreenEditProfileClicked: true));
    emit(state.copyWith(mainScreenEditProfileClicked: false));
  }
}
