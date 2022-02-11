

import 'package:equatable/equatable.dart';

import 'app_state.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppAuthStatusChanged extends AppEvent {
  const AppAuthStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}