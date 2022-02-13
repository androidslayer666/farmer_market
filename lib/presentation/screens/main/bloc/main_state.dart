import 'package:equatable/equatable.dart';
import 'package:farmer_market/repository/models/user.dart';

class MainState extends Equatable {
  const MainState({
    this.user,
  });

  final User? user;

  MainState copyWith({User? user}) {
    return MainState(user: user ?? this.user);
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
