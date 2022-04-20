import 'package:equatable/equatable.dart';


abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainScreenInit extends MainEvent {
  const MainScreenInit();
}

class MainScreenEditProfileClicked extends MainEvent {
  const MainScreenEditProfileClicked();
}

class MainScreenBackButtonPressedWhenStackIsClear extends MainEvent {
  const MainScreenBackButtonPressedWhenStackIsClear();
}

class MainScreenBackButtonPressed extends MainEvent {
  const MainScreenBackButtonPressed();
}

class MainScreenTabChanged extends MainEvent {
  const MainScreenTabChanged(this.tabIndex);

  final int tabIndex;

  @override
  List<Object> get props => [tabIndex];
}

