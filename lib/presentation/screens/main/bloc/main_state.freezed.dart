// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'main_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MainStateTearOff {
  const _$MainStateTearOff();

  _Initial call(
      {User? user,
      List<Product> listProducts = const [],
      String? errorWhileFetchingProducts,
      bool? isLoading}) {
    return _Initial(
      user: user,
      listProducts: listProducts,
      errorWhileFetchingProducts: errorWhileFetchingProducts,
      isLoading: isLoading,
    );
  }
}

/// @nodoc
const $MainState = _$MainStateTearOff();

/// @nodoc
mixin _$MainState {
  User? get user => throw _privateConstructorUsedError;
  List<Product> get listProducts => throw _privateConstructorUsedError;
  String? get errorWhileFetchingProducts => throw _privateConstructorUsedError;
  bool? get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainStateCopyWith<MainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res>;
  $Res call(
      {User? user,
      List<Product> listProducts,
      String? errorWhileFetchingProducts,
      bool? isLoading});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res> implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  final MainState _value;
  // ignore: unused_field
  final $Res Function(MainState) _then;

  @override
  $Res call({
    Object? user = freezed,
    Object? listProducts = freezed,
    Object? errorWhileFetchingProducts = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      listProducts: listProducts == freezed
          ? _value.listProducts
          : listProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      errorWhileFetchingProducts: errorWhileFetchingProducts == freezed
          ? _value.errorWhileFetchingProducts
          : errorWhileFetchingProducts // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
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
abstract class _$InitialCopyWith<$Res> implements $MainStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {User? user,
      List<Product> listProducts,
      String? errorWhileFetchingProducts,
      bool? isLoading});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$MainStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? user = freezed,
    Object? listProducts = freezed,
    Object? errorWhileFetchingProducts = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_Initial(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      listProducts: listProducts == freezed
          ? _value.listProducts
          : listProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      errorWhileFetchingProducts: errorWhileFetchingProducts == freezed
          ? _value.errorWhileFetchingProducts
          : errorWhileFetchingProducts // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.user,
      this.listProducts = const [],
      this.errorWhileFetchingProducts,
      this.isLoading});

  @override
  final User? user;
  @JsonKey()
  @override
  final List<Product> listProducts;
  @override
  final String? errorWhileFetchingProducts;
  @override
  final bool? isLoading;

  @override
  String toString() {
    return 'MainState(user: $user, listProducts: $listProducts, errorWhileFetchingProducts: $errorWhileFetchingProducts, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality()
                .equals(other.listProducts, listProducts) &&
            const DeepCollectionEquality().equals(
                other.errorWhileFetchingProducts, errorWhileFetchingProducts) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(listProducts),
      const DeepCollectionEquality().hash(errorWhileFetchingProducts),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements MainState {
  const factory _Initial(
      {User? user,
      List<Product> listProducts,
      String? errorWhileFetchingProducts,
      bool? isLoading}) = _$_Initial;

  @override
  User? get user;
  @override
  List<Product> get listProducts;
  @override
  String? get errorWhileFetchingProducts;
  @override
  bool? get isLoading;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
