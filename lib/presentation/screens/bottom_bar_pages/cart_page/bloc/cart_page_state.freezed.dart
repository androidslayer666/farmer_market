// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cart_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CartPageStateTearOff {
  const _$CartPageStateTearOff();

  _Initial call({Map<Product, int> productsWithQty = const {}}) {
    return _Initial(
      productsWithQty: productsWithQty,
    );
  }
}

/// @nodoc
const $CartPageState = _$CartPageStateTearOff();

/// @nodoc
mixin _$CartPageState {
  Map<Product, int> get productsWithQty => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartPageStateCopyWith<CartPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartPageStateCopyWith<$Res> {
  factory $CartPageStateCopyWith(
          CartPageState value, $Res Function(CartPageState) then) =
      _$CartPageStateCopyWithImpl<$Res>;
  $Res call({Map<Product, int> productsWithQty});
}

/// @nodoc
class _$CartPageStateCopyWithImpl<$Res>
    implements $CartPageStateCopyWith<$Res> {
  _$CartPageStateCopyWithImpl(this._value, this._then);

  final CartPageState _value;
  // ignore: unused_field
  final $Res Function(CartPageState) _then;

  @override
  $Res call({
    Object? productsWithQty = freezed,
  }) {
    return _then(_value.copyWith(
      productsWithQty: productsWithQty == freezed
          ? _value.productsWithQty
          : productsWithQty // ignore: cast_nullable_to_non_nullable
              as Map<Product, int>,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $CartPageStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({Map<Product, int> productsWithQty});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$CartPageStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? productsWithQty = freezed,
  }) {
    return _then(_Initial(
      productsWithQty: productsWithQty == freezed
          ? _value.productsWithQty
          : productsWithQty // ignore: cast_nullable_to_non_nullable
              as Map<Product, int>,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.productsWithQty = const {}});

  @JsonKey()
  @override
  final Map<Product, int> productsWithQty;

  @override
  String toString() {
    return 'CartPageState(productsWithQty: $productsWithQty)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.productsWithQty, productsWithQty));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(productsWithQty));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements CartPageState {
  const factory _Initial({Map<Product, int> productsWithQty}) = _$_Initial;

  @override
  Map<Product, int> get productsWithQty;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
