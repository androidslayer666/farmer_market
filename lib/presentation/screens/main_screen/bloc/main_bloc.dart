// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';

import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc()
      : super(const MainState()) {
    on<MainScreenInit>(_mainScreenInit);
    on<MainScreenTabChanged>(_onTabChanged);
    on<MainScreenBackButtonPressedWhenStackIsClear>(
        _backButtonPressedWhenStackIsClear);
    on<MainScreenBackButtonPressed>(_onBackButtonPressed);
    on<MainScreenFilterButtonClicked>(_onFilterButtonClicked);
  }


  _mainScreenInit(MainScreenInit event, Emitter<MainState> emit) async {
  }

  _onTabChanged(MainScreenTabChanged event, Emitter<MainState> emit) {
    if (event.tabIndex != state.pageStack.last) {
      final pageStack = [...state.pageStack, event.tabIndex];
      if (pageStack.length > 3) {
        pageStack.removeAt(0);
      }
      emit(state.copyWith(
          pageStack: pageStack, backButtonPressedWhenStackIsClear: false));
    }
  }

  _onBackButtonPressed(
      MainScreenBackButtonPressed event, Emitter<MainState> emit) {
    final pageStack = [...state.pageStack];
    if (pageStack.length > 1) {
      pageStack.removeLast();
    }
    emit(state.copyWith(pageStack: pageStack));
  }

  _backButtonPressedWhenStackIsClear(
      MainScreenBackButtonPressedWhenStackIsClear event,
      Emitter<MainState> emit) {
    emit(state.copyWith(backButtonPressedWhenStackIsClear: true));
  }

  _onFilterButtonClicked(
      MainScreenFilterButtonClicked event, Emitter<MainState> emit) {
    emit(state.copyWith(filterSwitchedOn: !state.filterSwitchedOn));
  }


}
