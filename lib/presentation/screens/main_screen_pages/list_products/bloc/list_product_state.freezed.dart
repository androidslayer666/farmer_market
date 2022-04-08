// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'list_product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ListProductStateTearOff {
  const _$ListProductStateTearOff();

  _Initial call(
      {String? lastDocumentId,
      List<Product> listProducts = const [],
      bool? isNewPortionLoading,
      bool? noMoreData,
      Filter? filter}) {
    return _Initial(
      lastDocumentId: lastDocumentId,
      listProducts: listProducts,
      isNewPortionLoading: isNewPortionLoading,
      noMoreData: noMoreData,
      filter: filter,
    );
  }
}

/// @nodoc
const $ListProductState = _$ListProductStateTearOff();

/// @nodoc
mixin _$ListProductState {
  String? get lastDocumentId => throw _privateConstructorUsedError;
  List<Product> get listProducts => throw _privateConstructorUsedError;
  bool? get isNewPortionLoading => throw _privateConstructorUsedError;
  bool? get noMoreData => throw _privateConstructorUsedError;
  Filter? get filter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListProductStateCopyWith<ListProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListProductStateCopyWith<$Res> {
  factory $ListProductStateCopyWith(
          ListProductState value, $Res Function(ListProductState) then) =
      _$ListProductStateCopyWithImpl<$Res>;
  $Res call(
      {String? lastDocumentId,
      List<Product> listProducts,
      bool? isNewPortionLoading,
      bool? noMoreData,
      Filter? filter});

  $FilterCopyWith<$Res>? get filter;
}

/// @nodoc
class _$ListProductStateCopyWithImpl<$Res>
    implements $ListProductStateCopyWith<$Res> {
  _$ListProductStateCopyWithImpl(this._value, this._then);

  final ListProductState _value;
  // ignore: unused_field
  final $Res Function(ListProductState) _then;

  @override
  $Res call({
    Object? lastDocumentId = freezed,
    Object? listProducts = freezed,
    Object? isNewPortionLoading = freezed,
    Object? noMoreData = freezed,
    Object? filter = freezed,
  }) {
    return _then(_value.copyWith(
      lastDocumentId: lastDocumentId == freezed
          ? _value.lastDocumentId
          : lastDocumentId // ignore: cast_nullable_to_non_nullable
              as String?,
      listProducts: listProducts == freezed
          ? _value.listProducts
          : listProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      isNewPortionLoading: isNewPortionLoading == freezed
          ? _value.isNewPortionLoading
          : isNewPortionLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      noMoreData: noMoreData == freezed
          ? _value.noMoreData
          : noMoreData // ignore: cast_nullable_to_non_nullable
              as bool?,
      filter: filter == freezed
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as Filter?,
    ));
  }

  @override
  $FilterCopyWith<$Res>? get filter {
    if (_value.filter == null) {
      return null;
    }

    return $FilterCopyWith<$Res>(_value.filter!, (value) {
      return _then(_value.copyWith(filter: value));
    });
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $ListProductStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? lastDocumentId,
      List<Product> listProducts,
      bool? isNewPortionLoading,
      bool? noMoreData,
      Filter? filter});

  @override
  $FilterCopyWith<$Res>? get filter;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$ListProductStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? lastDocumentId = freezed,
    Object? listProducts = freezed,
    Object? isNewPortionLoading = freezed,
    Object? noMoreData = freezed,
    Object? filter = freezed,
  }) {
    return _then(_Initial(
      lastDocumentId: lastDocumentId == freezed
          ? _value.lastDocumentId
          : lastDocumentId // ignore: cast_nullable_to_non_nullable
              as String?,
      listProducts: listProducts == freezed
          ? _value.listProducts
          : listProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      isNewPortionLoading: isNewPortionLoading == freezed
          ? _value.isNewPortionLoading
          : isNewPortionLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      noMoreData: noMoreData == freezed
          ? _value.noMoreData
          : noMoreData // ignore: cast_nullable_to_non_nullable
              as bool?,
      filter: filter == freezed
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as Filter?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.lastDocumentId,
      this.listProducts = const [],
      this.isNewPortionLoading,
      this.noMoreData,
      this.filter});

  @override
  final String? lastDocumentId;
  @JsonKey()
  @override
  final List<Product> listProducts;
  @override
  final bool? isNewPortionLoading;
  @override
  final bool? noMoreData;
  @override
  final Filter? filter;

  @override
  String toString() {
    return 'ListProductState(lastDocumentId: $lastDocumentId, listProducts: $listProducts, isNewPortionLoading: $isNewPortionLoading, noMoreData: $noMoreData, filter: $filter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.lastDocumentId, lastDocumentId) &&
            const DeepCollectionEquality()
                .equals(other.listProducts, listProducts) &&
            const DeepCollectionEquality()
                .equals(other.isNewPortionLoading, isNewPortionLoading) &&
            const DeepCollectionEquality()
                .equals(other.noMoreData, noMoreData) &&
            const DeepCollectionEquality().equals(other.filter, filter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(lastDocumentId),
      const DeepCollectionEquality().hash(listProducts),
      const DeepCollectionEquality().hash(isNewPortionLoading),
      const DeepCollectionEquality().hash(noMoreData),
      const DeepCollectionEquality().hash(filter));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements ListProductState {
  const factory _Initial(
      {String? lastDocumentId,
      List<Product> listProducts,
      bool? isNewPortionLoading,
      bool? noMoreData,
      Filter? filter}) = _$_Initial;

  @override
  String? get lastDocumentId;
  @override
  List<Product> get listProducts;
  @override
  bool? get isNewPortionLoading;
  @override
  bool? get noMoreData;
  @override
  Filter? get filter;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
