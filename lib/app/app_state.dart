import 'dart:typed_data';

import 'package:equatable/equatable.dart';

enum AuthenticationStatus { authenticated, unAuthenticated }

class AppState extends Equatable {
  const AppState(
      {this.authenticationStatus = AuthenticationStatus.unAuthenticated});

  final AuthenticationStatus authenticationStatus;

  AppState copyWith({AuthenticationStatus? authenticationStatus}) {
    return AppState(
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
    );
  }

  @override
  List<Object?> get props => [authenticationStatus];
}
