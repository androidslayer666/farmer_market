// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserDetailStateTearOff {
  const _$UserDetailStateTearOff();

  _Initial call(
      {bool? sendMessageIsClicked, User? user, List<Product>? listProducts}) {
    return _Initial(
      sendMessageIsClicked: sendMessageIsClicked,
      user: user,
      listProducts: listProducts,
    );
  }
}

/// @nodoc
const $UserDetailState = _$UserDetailStateTearOff();

/// @nodoc
mixin _$UserDetailState {
  bool? get sendMessageIsClicked => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  List<Product>? get listProducts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserDetailStateCopyWith<UserDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDetailStateCopyWith<$Res> {
  factory $UserDetailStateCopyWith(
          UserDetailState value, $Res Function(UserDetailState) then) =
      _$UserDetailStateCopyWithImpl<$Res>;
  $Res call(
      {bool? sendMessageIsClicked, User? user, List<Product>? listProducts});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$UserDetailStateCopyWithImpl<$Res>
    implements $UserDetailStateCopyWith<$Res> {
  _$UserDetailStateCopyWithImpl(this._value, this._then);

  final UserDetailState _value;
  // ignore: unused_field
  final $Res Function(UserDetailState) _then;

  @override
  $Res call({
    Object? sendMessageIsClicked = freezed,
    Object? user = freezed,
    Object? listProducts = freezed,
  }) {
    return _then(_value.copyWith(
      sendMessageIsClicked: sendMessageIsClicked == freezed
          ? _value.sendMessageIsClicked
          : sendMessageIsClicked // ignore: cast_nullable_to_non_nullable
              as bool?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      listProducts: listProducts == freezed
          ? _value.listProducts
          : listProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
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
    implements $UserDetailStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool? sendMessageIsClicked, User? user, List<Product>? listProducts});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$UserDetailStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? sendMessageIsClicked = freezed,
    Object? user = freezed,
    Object? listProducts = freezed,
  }) {
    return _then(_Initial(
      sendMessageIsClicked: sendMessageIsClicked == freezed
          ? _value.sendMessageIsClicked
          : sendMessageIsClicked // ignore: cast_nullable_to_non_nullable
              as bool?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      listProducts: listProducts == freezed
          ? _value.listProducts
          : listProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.sendMessageIsClicked, this.user, this.listProducts});

  @override
  final bool? sendMessageIsClicked;
  @override
  final User? user;
  @override
  final List<Product>? listProducts;

  @override
  String toString() {
    return 'UserDetailState(sendMessageIsClicked: $sendMessageIsClicked, user: $user, listProducts: $listProducts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.sendMessageIsClicked, sendMessageIsClicked) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality()
                .equals(other.listProducts, listProducts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(sendMessageIsClicked),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(listProducts));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements UserDetailState {
  const factory _Initial(
      {bool? sendMessageIsClicked,
      User? user,
      List<Product>? listProducts}) = _$_Initial;

  @override
  bool? get sendMessageIsClicked;
  @override
  User? get user;
  @override
  List<Product>? get listProducts;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
