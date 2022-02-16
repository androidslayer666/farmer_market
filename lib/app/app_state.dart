import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  const AppState(
      {required this.authenticated});

  final bool authenticated;

  AppState copyWith({bool? authenticated}) {
    return AppState(
      authenticated: authenticated ?? this.authenticated,
    );
  }

  @override
  List<Object?> get props => [authenticated];
}
