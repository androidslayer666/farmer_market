// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserProductsStateTearOff {
  const _$UserProductsStateTearOff();

  _Initial call({List<Product> listProducts = const [], bool? isLoading}) {
    return _Initial(
      listProducts: listProducts,
      isLoading: isLoading,
    );
  }
}

/// @nodoc
const $UserProductsState = _$UserProductsStateTearOff();

/// @nodoc
mixin _$UserProductsState {
  List<Product> get listProducts => throw _privateConstructorUsedError;
  bool? get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserProductsStateCopyWith<UserProductsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProductsStateCopyWith<$Res> {
  factory $UserProductsStateCopyWith(
          UserProductsState value, $Res Function(UserProductsState) then) =
      _$UserProductsStateCopyWithImpl<$Res>;
  $Res call({List<Product> listProducts, bool? isLoading});
}

/// @nodoc
class _$UserProductsStateCopyWithImpl<$Res>
    implements $UserProductsStateCopyWith<$Res> {
  _$UserProductsStateCopyWithImpl(this._value, this._then);

  final UserProductsState _value;
  // ignore: unused_field
  final $Res Function(UserProductsState) _then;

  @override
  $Res call({
    Object? listProducts = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      listProducts: listProducts == freezed
          ? _value.listProducts
          : listProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $UserProductsStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({List<Product> listProducts, bool? isLoading});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$UserProductsStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? listProducts = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_Initial(
      listProducts: listProducts == freezed
          ? _value.listProducts
          : listProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.listProducts = const [], this.isLoading});

  @JsonKey()
  @override
  final List<Product> listProducts;
  @override
  final bool? isLoading;

  @override
  String toString() {
    return 'UserProductsState(listProducts: $listProducts, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.listProducts, listProducts) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(listProducts),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements UserProductsState {
  const factory _Initial({List<Product> listProducts, bool? isLoading}) =
      _$_Initial;

  @override
  List<Product> get listProducts;
  @override
  bool? get isLoading;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
