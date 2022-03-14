// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product_detail_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProductDetailScreenStateTearOff {
  const _$ProductDetailScreenStateTearOff();

  _Initial call({User? user, bool? problemWithFetchingUser}) {
    return _Initial(
      user: user,
      problemWithFetchingUser: problemWithFetchingUser,
    );
  }
}

/// @nodoc
const $ProductDetailScreenState = _$ProductDetailScreenStateTearOff();

/// @nodoc
mixin _$ProductDetailScreenState {
  User? get user => throw _privateConstructorUsedError;
  bool? get problemWithFetchingUser => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductDetailScreenStateCopyWith<ProductDetailScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDetailScreenStateCopyWith<$Res> {
  factory $ProductDetailScreenStateCopyWith(ProductDetailScreenState value,
          $Res Function(ProductDetailScreenState) then) =
      _$ProductDetailScreenStateCopyWithImpl<$Res>;
  $Res call({User? user, bool? problemWithFetchingUser});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$ProductDetailScreenStateCopyWithImpl<$Res>
    implements $ProductDetailScreenStateCopyWith<$Res> {
  _$ProductDetailScreenStateCopyWithImpl(this._value, this._then);

  final ProductDetailScreenState _value;
  // ignore: unused_field
  final $Res Function(ProductDetailScreenState) _then;

  @override
  $Res call({
    Object? user = freezed,
    Object? problemWithFetchingUser = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      problemWithFetchingUser: problemWithFetchingUser == freezed
          ? _value.problemWithFetchingUser
          : problemWithFetchingUser // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  @override
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $ProductDetailScreenStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({User? user, bool? problemWithFetchingUser});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$ProductDetailScreenStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? user = freezed,
    Object? problemWithFetchingUser = freezed,
  }) {
    return _then(_Initial(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      problemWithFetchingUser: problemWithFetchingUser == freezed
          ? _value.problemWithFetchingUser
          : problemWithFetchingUser // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.user, this.problemWithFetchingUser});

  @override
  final User? user;
  @override
  final bool? problemWithFetchingUser;

  @override
  String toString() {
    return 'ProductDetailScreenState(user: $user, problemWithFetchingUser: $problemWithFetchingUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(
                other.problemWithFetchingUser, problemWithFetchingUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(problemWithFetchingUser));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements ProductDetailScreenState {
  const factory _Initial({User? user, bool? problemWithFetchingUser}) =
      _$_Initial;

  @override
  User? get user;
  @override
  bool? get problemWithFetchingUser;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
