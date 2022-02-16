import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainScreenInit extends MainEvent{
  const MainScreenInit();
}

class MainScreenEditProfileClicked extends MainEvent{
  const MainScreenEditProfileClicked();
}

