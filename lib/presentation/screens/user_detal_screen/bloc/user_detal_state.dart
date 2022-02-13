import 'dart:typed_data';

import 'package:equatable/equatable.dart';

enum UserDetailStatus { success, failure, unknown }

class UserDetailState extends Equatable {
  const UserDetailState(
      {this.name = 'oleg',
      this.phoneIsValid = true,
      this.phone = '+79200657987',
      this.description = 'wzyan762',
      this.isLoading = false,
      this.signInStatus = UserDetailStatus.unknown,
      this.image});

  final String name;
  final bool phoneIsValid;
  final String phone;
  final String description;
  final bool isLoading;
  final UserDetailStatus signInStatus;
  final Uint8List? image;

  UserDetailState copyWith(
      {String? name,
      bool? phoneIsValid,
      String? phone,
      String? description,
      bool? isLoading,
      UserDetailStatus? signInStatus,
      Uint8List? image}) {
    return UserDetailState(
      name: name ?? this.name,
      phoneIsValid: phoneIsValid ?? this.phoneIsValid,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      signInStatus: signInStatus ?? this.signInStatus,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phoneIsValid,
        phone,
        description,
        isLoading,
        signInStatus,
        image
      ];
}
