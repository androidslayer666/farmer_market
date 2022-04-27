// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CartStateTearOff {
  const _$CartStateTearOff();

  _Initial call(
      {Cart cart = const Cart(),
      Map<User?, List<CartItem>>? mapUserToItems,
      bool? successfullyAddedToCart,
      bool? successfullyDeletedToCart}) {
    return _Initial(
      cart: cart,
      mapUserToItems: mapUserToItems,
      successfullyAddedToCart: successfullyAddedToCart,
      successfullyDeletedToCart: successfullyDeletedToCart,
    );
  }
}

/// @nodoc
const $CartState = _$CartStateTearOff();

/// @nodoc
mixin _$CartState {
  Cart get cart => throw _privateConstructorUsedError;
  Map<User?, List<CartItem>>? get mapUserToItems =>
      throw _privateConstructorUsedError;
  bool? get successfullyAddedToCart => throw _privateConstructorUsedError;
  bool? get successfullyDeletedToCart => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartStateCopyWith<CartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res>;
  $Res call(
      {Cart cart,
      Map<User?, List<CartItem>>? mapUserToItems,
      bool? successfullyAddedToCart,
      bool? successfullyDeletedToCart});

  $CartCopyWith<$Res> get cart;
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res> implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  final CartState _value;
  // ignore: unused_field
  final $Res Function(CartState) _then;

  @override
  $Res call({
    Object? cart = freezed,
    Object? mapUserToItems = freezed,
    Object? successfullyAddedToCart = freezed,
    Object? successfullyDeletedToCart = freezed,
  }) {
    return _then(_value.copyWith(
      cart: cart == freezed
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Cart,
      mapUserToItems: mapUserToItems == freezed
          ? _value.mapUserToItems
          : mapUserToItems // ignore: cast_nullable_to_non_nullable
              as Map<User?, List<CartItem>>?,
      successfullyAddedToCart: successfullyAddedToCart == freezed
          ? _value.successfullyAddedToCart
          : successfullyAddedToCart // ignore: cast_nullable_to_non_nullable
              as bool?,
      successfullyDeletedToCart: successfullyDeletedToCart == freezed
          ? _value.successfullyDeletedToCart
          : successfullyDeletedToCart // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  @override
  $CartCopyWith<$Res> get cart {
    return $CartCopyWith<$Res>(_value.cart, (value) {
      return _then(_value.copyWith(cart: value));
    });
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {Cart cart,
      Map<User?, List<CartItem>>? mapUserToItems,
      bool? successfullyAddedToCart,
      bool? successfullyDeletedToCart});

  @override
  $CartCopyWith<$Res> get cart;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$CartStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? cart = freezed,
    Object? mapUserToItems = freezed,
    Object? successfullyAddedToCart = freezed,
    Object? successfullyDeletedToCart = freezed,
  }) {
    return _then(_Initial(
      cart: cart == freezed
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Cart,
      mapUserToItems: mapUserToItems == freezed
          ? _value.mapUserToItems
          : mapUserToItems // ignore: cast_nullable_to_non_nullable
              as Map<User?, List<CartItem>>?,
      successfullyAddedToCart: successfullyAddedToCart == freezed
          ? _value.successfullyAddedToCart
          : successfullyAddedToCart // ignore: cast_nullable_to_non_nullable
              as bool?,
      successfullyDeletedToCart: successfullyDeletedToCart == freezed
          ? _value.successfullyDeletedToCart
          : successfullyDeletedToCart // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.cart = const Cart(),
      this.mapUserToItems,
      this.successfullyAddedToCart,
      this.successfullyDeletedToCart});

  @JsonKey()
  @override
  final Cart cart;
  @override
  final Map<User?, List<CartItem>>? mapUserToItems;
  @override
  final bool? successfullyAddedToCart;
  @override
  final bool? successfullyDeletedToCart;

  @override
  String toString() {
    return 'CartState(cart: $cart, mapUserToItems: $mapUserToItems, successfullyAddedToCart: $successfullyAddedToCart, successfullyDeletedToCart: $successfullyDeletedToCart)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.cart, cart) &&
            const DeepCollectionEquality()
                .equals(other.mapUserToItems, mapUserToItems) &&
            const DeepCollectionEquality().equals(
                other.successfullyAddedToCart, successfullyAddedToCart) &&
            const DeepCollectionEquality().equals(
                other.successfullyDeletedToCart, successfullyDeletedToCart));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(cart),
      const DeepCollectionEquality().hash(mapUserToItems),
      const DeepCollectionEquality().hash(successfullyAddedToCart),
      const DeepCollectionEquality().hash(successfullyDeletedToCart));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements CartState {
  const factory _Initial(
      {Cart cart,
      Map<User?, List<CartItem>>? mapUserToItems,
      bool? successfullyAddedToCart,
      bool? successfullyDeletedToCart}) = _$_Initial;

  @override
  Cart get cart;
  @override
  Map<User?, List<CartItem>>? get mapUserToItems;
  @override
  bool? get successfullyAddedToCart;
  @override
  bool? get successfullyDeletedToCart;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
