


import 'package:equatable/equatable.dart';

import '../../../../data/models/api/address.dart';
import '../../../../data/models/user/user.dart';

abstract class EditUserEvent extends Equatable {
  const EditUserEvent();

  @override
  List<Object?> get props => [];
}

class UserDetailInit extends EditUserEvent{
  const UserDetailInit(this.user);
  final User? user;
  @override
  List<Object?> get props => [user];
}

class UserDetailNameChanged extends EditUserEvent {
  const UserDetailNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class UserDetailDescriptionChanged extends EditUserEvent {
  const UserDetailDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class UserDetailIsSellerChanged extends EditUserEvent {
  const UserDetailIsSellerChanged(this.isSeller);

  final bool isSeller;

  @override
  List<Object> get props => [isSeller];
}


class UserDetailAddressChanged extends EditUserEvent {
  const UserDetailAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

class UserDetailImageAddClicked extends EditUserEvent {
  const UserDetailImageAddClicked();

  @override
  List<Object> get props => [];
}

class UserDetailAddressOptionSubmitted extends EditUserEvent {
  const UserDetailAddressOptionSubmitted(this.address);

  final Address address;

  @override
  List<Object> get props => [address];
}

class UserDetailSubmitted extends EditUserEvent {
  const UserDetailSubmitted();
}

class UserDetailLogOutClicked extends EditUserEvent{
  const UserDetailLogOutClicked();
}