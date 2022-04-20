// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'shipping_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ShippingStateTearOff {
  const _$ShippingStateTearOff();

  _Initial call(
      {List<Order> listFinishedOrders = const [],
      List<Order> listCurrentOrders = const [],
      bool? orderUpdateResult}) {
    return _Initial(
      listFinishedOrders: listFinishedOrders,
      listCurrentOrders: listCurrentOrders,
      orderUpdateResult: orderUpdateResult,
    );
  }
}

/// @nodoc
const $ShippingState = _$ShippingStateTearOff();

/// @nodoc
mixin _$ShippingState {
  List<Order> get listFinishedOrders => throw _privateConstructorUsedError;
  List<Order> get listCurrentOrders => throw _privateConstructorUsedError;
  bool? get orderUpdateResult => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShippingStateCopyWith<ShippingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShippingStateCopyWith<$Res> {
  factory $ShippingStateCopyWith(
          ShippingState value, $Res Function(ShippingState) then) =
      _$ShippingStateCopyWithImpl<$Res>;
  $Res call(
      {List<Order> listFinishedOrders,
      List<Order> listCurrentOrders,
      bool? orderUpdateResult});
}

/// @nodoc
class _$ShippingStateCopyWithImpl<$Res>
    implements $ShippingStateCopyWith<$Res> {
  _$ShippingStateCopyWithImpl(this._value, this._then);

  final ShippingState _value;
  // ignore: unused_field
  final $Res Function(ShippingState) _then;

  @override
  $Res call({
    Object? listFinishedOrders = freezed,
    Object? listCurrentOrders = freezed,
    Object? orderUpdateResult = freezed,
  }) {
    return _then(_value.copyWith(
      listFinishedOrders: listFinishedOrders == freezed
          ? _value.listFinishedOrders
          : listFinishedOrders // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      listCurrentOrders: listCurrentOrders == freezed
          ? _value.listCurrentOrders
          : listCurrentOrders // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      orderUpdateResult: orderUpdateResult == freezed
          ? _value.orderUpdateResult
          : orderUpdateResult // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $ShippingStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Order> listFinishedOrders,
      List<Order> listCurrentOrders,
      bool? orderUpdateResult});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$ShippingStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? listFinishedOrders = freezed,
    Object? listCurrentOrders = freezed,
    Object? orderUpdateResult = freezed,
  }) {
    return _then(_Initial(
      listFinishedOrders: listFinishedOrders == freezed
          ? _value.listFinishedOrders
          : listFinishedOrders // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      listCurrentOrders: listCurrentOrders == freezed
          ? _value.listCurrentOrders
          : listCurrentOrders // ignore: cast_nullable_to_non_nullable
              as List<Order>,
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
      {this.listFinishedOrders = const [],
      this.listCurrentOrders = const [],
      this.orderUpdateResult});

  @JsonKey()
  @override
  final List<Order> listFinishedOrders;
  @JsonKey()
  @override
  final List<Order> listCurrentOrders;
  @override
  final bool? orderUpdateResult;

  @override
  String toString() {
    return 'ShippingState(listFinishedOrders: $listFinishedOrders, listCurrentOrders: $listCurrentOrders, orderUpdateResult: $orderUpdateResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.listFinishedOrders, listFinishedOrders) &&
            const DeepCollectionEquality()
                .equals(other.listCurrentOrders, listCurrentOrders) &&
            const DeepCollectionEquality()
                .equals(other.orderUpdateResult, orderUpdateResult));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(listFinishedOrders),
      const DeepCollectionEquality().hash(listCurrentOrders),
      const DeepCollectionEquality().hash(orderUpdateResult));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements ShippingState {
  const factory _Initial(
      {List<Order> listFinishedOrders,
      List<Order> listCurrentOrders,
      bool? orderUpdateResult}) = _$_Initial;

  @override
  List<Order> get listFinishedOrders;
  @override
  List<Order> get listCurrentOrders;
  @override
  bool? get orderUpdateResult;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
