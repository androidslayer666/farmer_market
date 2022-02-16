import 'package:farmer_market/repository/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({User? user, bool? mainScreenEditProfileClicked}) =
      _Initial;
}
