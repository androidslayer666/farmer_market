// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

  _Initial call(
      {bool authenticated = false,
      User? currentUser,
      AppStateUserFetchStatus userFetchStatus = AppStateUserFetchStatus.unknown,
      String? userFetchingError}) {
    return _Initial(
      authenticated: authenticated,
      currentUser: currentUser,
      userFetchStatus: userFetchStatus,
      userFetchingError: userFetchingError,
    );
  }
}

/// @nodoc
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  bool get authenticated => throw _privateConstructorUsedError;
  User? get currentUser => throw _privateConstructorUsedError;
  AppStateUserFetchStatus get userFetchStatus =>
      throw _privateConstructorUsedError;
  String? get userFetchingError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call(
      {bool authenticated,
      User? currentUser,
      AppStateUserFetchStatus userFetchStatus,
      String? userFetchingError});

  $UserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;

  @override
  $Res call({
    Object? authenticated = freezed,
    Object? currentUser = freezed,
    Object? userFetchStatus = freezed,
    Object? userFetchingError = freezed,
  }) {
    return _then(_value.copyWith(
      authenticated: authenticated == freezed
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUser: currentUser == freezed
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as User?,
      userFetchStatus: userFetchStatus == freezed
          ? _value.userFetchStatus
          : userFetchStatus // ignore: cast_nullable_to_non_nullable
              as AppStateUserFetchStatus,
      userFetchingError: userFetchingError == freezed
          ? _value.userFetchingError
          : userFetchingError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $UserCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value));
    });
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool authenticated,
      User? currentUser,
      AppStateUserFetchStatus userFetchStatus,
      String? userFetchingError});

  @override
  $UserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? authenticated = freezed,
    Object? currentUser = freezed,
    Object? userFetchStatus = freezed,
    Object? userFetchingError = freezed,
  }) {
    return _then(_Initial(
      authenticated: authenticated == freezed
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUser: currentUser == freezed
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as User?,
      userFetchStatus: userFetchStatus == freezed
          ? _value.userFetchStatus
          : userFetchStatus // ignore: cast_nullable_to_non_nullable
              as AppStateUserFetchStatus,
      userFetchingError: userFetchingError == freezed
          ? _value.userFetchingError
          : userFetchingError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.authenticated = false,
      this.currentUser,
      this.userFetchStatus = AppStateUserFetchStatus.unknown,
      this.userFetchingError});

  @JsonKey()
  @override
  final bool authenticated;
  @override
  final User? currentUser;
  @JsonKey()
  @override
  final AppStateUserFetchStatus userFetchStatus;
  @override
  final String? userFetchingError;

  @override
  String toString() {
    return 'AppState(authenticated: $authenticated, currentUser: $currentUser, userFetchStatus: $userFetchStatus, userFetchingError: $userFetchingError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.authenticated, authenticated) &&
            const DeepCollectionEquality()
                .equals(other.currentUser, currentUser) &&
            const DeepCollectionEquality()
                .equals(other.userFetchStatus, userFetchStatus) &&
            const DeepCollectionEquality()
                .equals(other.userFetchingError, userFetchingError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(authenticated),
      const DeepCollectionEquality().hash(currentUser),
      const DeepCollectionEquality().hash(userFetchStatus),
      const DeepCollectionEquality().hash(userFetchingError));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements AppState {
  const factory _Initial(
      {bool authenticated,
      User? currentUser,
      AppStateUserFetchStatus userFetchStatus,
      String? userFetchingError}) = _$_Initial;

  @override
  bool get authenticated;
  @override
  User? get currentUser;
  @override
  AppStateUserFetchStatus get userFetchStatus;
  @override
  String? get userFetchingError;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
