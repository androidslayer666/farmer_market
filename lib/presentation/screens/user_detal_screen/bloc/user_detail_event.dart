

import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class UserDetailInit extends UserDetailEvent{
  const UserDetailInit();
}

class UserDetailNameChanged extends UserDetailEvent {
  const UserDetailNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class UserDetailDescriptionChanged extends UserDetailEvent {
  const UserDetailDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class UserDetailImageAddClicked extends UserDetailEvent {
  const UserDetailImageAddClicked();

  @override
  List<Object> get props => [];
}

class UserDetailSubmitted extends UserDetailEvent {
  const UserDetailSubmitted();
}

class UserDetailLogOutClicked extends UserDetailEvent{
  const UserDetailLogOutClicked();
}