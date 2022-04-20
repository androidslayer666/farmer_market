import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/user/user.dart';

part 'app_state.freezed.dart';

enum AppStateUserFetchStatus{success, loading, failure, unknown}

@freezed
class AppState with _$AppState {
  const factory AppState(
      {
        @Default(false) bool authenticated,
        User? currentUser,
        @Default(AppStateUserFetchStatus.unknown) AppStateUserFetchStatus userFetchStatus,
        String? userFetchingError
      }) = _Initial;
}