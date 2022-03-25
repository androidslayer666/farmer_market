// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Cart _$CartFromJson(Map<String, dynamic> json) {
  return _Initial.fromJson(json);
}

/// @nodoc
class _$CartTearOff {
  const _$CartTearOff();

  _Initial call(
      {String? id,
      String? userId,
      @JsonKey(toJson: listCartItemsToJson) List<CartItem> cartItems = const [],
      DateTime? dateCreated}) {
    return _Initial(
      id: id,
      userId: userId,
      cartItems: cartItems,
      dateCreated: dateCreated,
    );
  }

  Cart fromJson(Map<String, Object?> json) {
    return Cart.fromJson(json);
  }
}

/// @nodoc
const $Cart = _$CartTearOff();

/// @nodoc
mixin _$Cart {
  String? get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(toJson: listCartItemsToJson)
  List<CartItem> get cartItems => throw _privateConstructorUsedError;
  DateTime? get dateCreated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartCopyWith<Cart> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartCopyWith<$Res> {
  factory $CartCopyWith(Cart value, $Res Function(Cart) then) =
      _$CartCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? userId,
      @JsonKey(toJson: listCartItemsToJson) List<CartItem> cartItems,
      DateTime? dateCreated});
}

/// @nodoc
class _$CartCopyWithImpl<$Res> implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._value, this._then);

  final Cart _value;
  // ignore: unused_field
  final $Res Function(Cart) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? cartItems = freezed,
    Object? dateCreated = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      cartItems: cartItems == freezed
          ? _value.cartItems
          : cartItems // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      dateCreated: dateCreated == freezed
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? userId,
      @JsonKey(toJson: listCartItemsToJson) List<CartItem> cartItems,
      DateTime? dateCreated});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$CartCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? cartItems = freezed,
    Object? dateCreated = freezed,
  }) {
    return _then(_Initial(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      cartItems: cartItems == freezed
          ? _value.cartItems
          : cartItems // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      dateCreated: dateCreated == freezed
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Initial implements _Initial {
  const _$_Initial(
      {this.id,
      this.userId,
      @JsonKey(toJson: listCartItemsToJson) this.cartItems = const [],
      this.dateCreated});

  factory _$_Initial.fromJson(Map<String, dynamic> json) =>
      _$$_InitialFromJson(json);

  @override
  final String? id;
  @override
  final String? userId;
  @override
  @JsonKey(toJson: listCartItemsToJson)
  final List<CartItem> cartItems;
  @override
  final DateTime? dateCreated;

  @override
  String toString() {
    return 'Cart(id: $id, userId: $userId, cartItems: $cartItems, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.cartItems, cartItems) &&
            const DeepCollectionEquality()
                .equals(other.dateCreated, dateCreated));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(cartItems),
      const DeepCollectionEquality().hash(dateCreated));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InitialToJson(this);
  }
}

abstract class _Initial implements Cart {
  const factory _Initial(
      {String? id,
      String? userId,
      @JsonKey(toJson: listCartItemsToJson) List<CartItem> cartItems,
      DateTime? dateCreated}) = _$_Initial;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$_Initial.fromJson;

  @override
  String? get id;
  @override
  String? get userId;
  @override
  @JsonKey(toJson: listCartItemsToJson)
  List<CartItem> get cartItems;
  @override
  DateTime? get dateCreated;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
