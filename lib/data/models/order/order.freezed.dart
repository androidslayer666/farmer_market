// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Initial.fromJson(json);
}

/// @nodoc
class _$OrderTearOff {
  const _$OrderTearOff();

  _Initial call(
      {String? id,
      String? shipperId,
      String? purchaserId,
      @JsonKey(toJson: listCartItemsToJson) List<CartItem> cartItems = const [],
      DateTime? confirmedShippingDate,
      DateTime? dateCreated}) {
    return _Initial(
      id: id,
      shipperId: shipperId,
      purchaserId: purchaserId,
      cartItems: cartItems,
      confirmedShippingDate: confirmedShippingDate,
      dateCreated: dateCreated,
    );
  }

  Order fromJson(Map<String, Object?> json) {
    return Order.fromJson(json);
  }
}

/// @nodoc
const $Order = _$OrderTearOff();

/// @nodoc
mixin _$Order {
  String? get id => throw _privateConstructorUsedError;
  String? get shipperId => throw _privateConstructorUsedError;
  String? get purchaserId => throw _privateConstructorUsedError;
  @JsonKey(toJson: listCartItemsToJson)
  List<CartItem> get cartItems => throw _privateConstructorUsedError;
  DateTime? get confirmedShippingDate => throw _privateConstructorUsedError;
  DateTime? get dateCreated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? shipperId,
      String? purchaserId,
      @JsonKey(toJson: listCartItemsToJson) List<CartItem> cartItems,
      DateTime? confirmedShippingDate,
      DateTime? dateCreated});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res> implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  final Order _value;
  // ignore: unused_field
  final $Res Function(Order) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? shipperId = freezed,
    Object? purchaserId = freezed,
    Object? cartItems = freezed,
    Object? confirmedShippingDate = freezed,
    Object? dateCreated = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      shipperId: shipperId == freezed
          ? _value.shipperId
          : shipperId // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaserId: purchaserId == freezed
          ? _value.purchaserId
          : purchaserId // ignore: cast_nullable_to_non_nullable
              as String?,
      cartItems: cartItems == freezed
          ? _value.cartItems
          : cartItems // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      confirmedShippingDate: confirmedShippingDate == freezed
          ? _value.confirmedShippingDate
          : confirmedShippingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateCreated: dateCreated == freezed
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? shipperId,
      String? purchaserId,
      @JsonKey(toJson: listCartItemsToJson) List<CartItem> cartItems,
      DateTime? confirmedShippingDate,
      DateTime? dateCreated});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$OrderCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? id = freezed,
    Object? shipperId = freezed,
    Object? purchaserId = freezed,
    Object? cartItems = freezed,
    Object? confirmedShippingDate = freezed,
    Object? dateCreated = freezed,
  }) {
    return _then(_Initial(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      shipperId: shipperId == freezed
          ? _value.shipperId
          : shipperId // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaserId: purchaserId == freezed
          ? _value.purchaserId
          : purchaserId // ignore: cast_nullable_to_non_nullable
              as String?,
      cartItems: cartItems == freezed
          ? _value.cartItems
          : cartItems // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      confirmedShippingDate: confirmedShippingDate == freezed
          ? _value.confirmedShippingDate
          : confirmedShippingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      this.shipperId,
      this.purchaserId,
      @JsonKey(toJson: listCartItemsToJson) this.cartItems = const [],
      this.confirmedShippingDate,
      this.dateCreated});

  factory _$_Initial.fromJson(Map<String, dynamic> json) =>
      _$$_InitialFromJson(json);

  @override
  final String? id;
  @override
  final String? shipperId;
  @override
  final String? purchaserId;
  @override
  @JsonKey(toJson: listCartItemsToJson)
  final List<CartItem> cartItems;
  @override
  final DateTime? confirmedShippingDate;
  @override
  final DateTime? dateCreated;

  @override
  String toString() {
    return 'Order(id: $id, shipperId: $shipperId, purchaserId: $purchaserId, cartItems: $cartItems, confirmedShippingDate: $confirmedShippingDate, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.shipperId, shipperId) &&
            const DeepCollectionEquality()
                .equals(other.purchaserId, purchaserId) &&
            const DeepCollectionEquality().equals(other.cartItems, cartItems) &&
            const DeepCollectionEquality()
                .equals(other.confirmedShippingDate, confirmedShippingDate) &&
            const DeepCollectionEquality()
                .equals(other.dateCreated, dateCreated));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(shipperId),
      const DeepCollectionEquality().hash(purchaserId),
      const DeepCollectionEquality().hash(cartItems),
      const DeepCollectionEquality().hash(confirmedShippingDate),
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

abstract class _Initial implements Order {
  const factory _Initial(
      {String? id,
      String? shipperId,
      String? purchaserId,
      @JsonKey(toJson: listCartItemsToJson) List<CartItem> cartItems,
      DateTime? confirmedShippingDate,
      DateTime? dateCreated}) = _$_Initial;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$_Initial.fromJson;

  @override
  String? get id;
  @override
  String? get shipperId;
  @override
  String? get purchaserId;
  @override
  @JsonKey(toJson: listCartItemsToJson)
  List<CartItem> get cartItems;
  @override
  DateTime? get confirmedShippingDate;
  @override
  DateTime? get dateCreated;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
