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
      Cart cart = const Cart(),
      List<Order> listOrders = const [],
      User? currentUser,
      bool? orderUpdateResult}) {
    return _Initial(
      authenticated: authenticated,
      cart: cart,
      listOrders: listOrders,
      currentUser: currentUser,
      orderUpdateResult: orderUpdateResult,
    );
  }
}

/// @nodoc
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  bool get authenticated => throw _privateConstructorUsedError;
  Cart get cart => throw _privateConstructorUsedError;
  List<Order> get listOrders => throw _privateConstructorUsedError;
  User? get currentUser => throw _privateConstructorUsedError;
  bool? get orderUpdateResult => throw _privateConstructorUsedError;

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
      Cart cart,
      List<Order> listOrders,
      User? currentUser,
      bool? orderUpdateResult});

  $CartCopyWith<$Res> get cart;
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
    Object? cart = freezed,
    Object? listOrders = freezed,
    Object? currentUser = freezed,
    Object? orderUpdateResult = freezed,
  }) {
    return _then(_value.copyWith(
      authenticated: authenticated == freezed
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      cart: cart == freezed
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Cart,
      listOrders: listOrders == freezed
          ? _value.listOrders
          : listOrders // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      currentUser: currentUser == freezed
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as User?,
      orderUpdateResult: orderUpdateResult == freezed
          ? _value.orderUpdateResult
          : orderUpdateResult // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  @override
  $CartCopyWith<$Res> get cart {
    return $CartCopyWith<$Res>(_value.cart, (value) {
      return _then(_value.copyWith(cart: value));
    });
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
      Cart cart,
      List<Order> listOrders,
      User? currentUser,
      bool? orderUpdateResult});

  @override
  $CartCopyWith<$Res> get cart;
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
    Object? cart = freezed,
    Object? listOrders = freezed,
    Object? currentUser = freezed,
    Object? orderUpdateResult = freezed,
  }) {
    return _then(_Initial(
      authenticated: authenticated == freezed
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      cart: cart == freezed
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Cart,
      listOrders: listOrders == freezed
          ? _value.listOrders
          : listOrders // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      currentUser: currentUser == freezed
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as User?,
      orderUpdateResult: orderUpdateResult == freezed
          ? _value.orderUpdateResult
          : orderUpdateResult // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.authenticated = false,
      this.cart = const Cart(),
      this.listOrders = const [],
      this.currentUser,
      this.orderUpdateResult});

  @JsonKey()
  @override
  final bool authenticated;
  @JsonKey()
  @override
  final Cart cart;
  @JsonKey()
  @override
  final List<Order> listOrders;
  @override
  final User? currentUser;
  @override
  final bool? orderUpdateResult;

  @override
  String toString() {
    return 'AppState(authenticated: $authenticated, cart: $cart, listOrders: $listOrders, currentUser: $currentUser, orderUpdateResult: $orderUpdateResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.authenticated, authenticated) &&
            const DeepCollectionEquality().equals(other.cart, cart) &&
            const DeepCollectionEquality()
                .equals(other.listOrders, listOrders) &&
            const DeepCollectionEquality()
                .equals(other.currentUser, currentUser) &&
            const DeepCollectionEquality()
                .equals(other.orderUpdateResult, orderUpdateResult));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(authenticated),
      const DeepCollectionEquality().hash(cart),
      const DeepCollectionEquality().hash(listOrders),
      const DeepCollectionEquality().hash(currentUser),
      const DeepCollectionEquality().hash(orderUpdateResult));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements AppState {
  const factory _Initial(
      {bool authenticated,
      Cart cart,
      List<Order> listOrders,
      User? currentUser,
      bool? orderUpdateResult}) = _$_Initial;

  @override
  bool get authenticated;
  @override
  Cart get cart;
  @override
  List<Order> get listOrders;
  @override
  User? get currentUser;
  @override
  bool? get orderUpdateResult;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
