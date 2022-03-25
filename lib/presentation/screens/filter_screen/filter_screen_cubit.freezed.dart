// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'filter_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FilterScreenStateTearOff {
  const _$FilterScreenStateTearOff();

  _Initial call({Filter filter = const Filter()}) {
    return _Initial(
      filter: filter,
    );
  }
}

/// @nodoc
const $FilterScreenState = _$FilterScreenStateTearOff();

/// @nodoc
mixin _$FilterScreenState {
  Filter get filter => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FilterScreenStateCopyWith<FilterScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterScreenStateCopyWith<$Res> {
  factory $FilterScreenStateCopyWith(
          FilterScreenState value, $Res Function(FilterScreenState) then) =
      _$FilterScreenStateCopyWithImpl<$Res>;
  $Res call({Filter filter});

  $FilterCopyWith<$Res> get filter;
}

/// @nodoc
class _$FilterScreenStateCopyWithImpl<$Res>
    implements $FilterScreenStateCopyWith<$Res> {
  _$FilterScreenStateCopyWithImpl(this._value, this._then);

  final FilterScreenState _value;
  // ignore: unused_field
  final $Res Function(FilterScreenState) _then;

  @override
  $Res call({
    Object? filter = freezed,
  }) {
    return _then(_value.copyWith(
      filter: filter == freezed
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as Filter,
    ));
  }

  @override
  $FilterCopyWith<$Res> get filter {
    return $FilterCopyWith<$Res>(_value.filter, (value) {
      return _then(_value.copyWith(filter: value));
    });
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $FilterScreenStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({Filter filter});

  @override
  $FilterCopyWith<$Res> get filter;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$FilterScreenStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? filter = freezed,
  }) {
    return _then(_Initial(
      filter: filter == freezed
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as Filter,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.filter = const Filter()});

  @JsonKey()
  @override
  final Filter filter;

  @override
  String toString() {
    return 'FilterScreenState(filter: $filter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.filter, filter));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(filter));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements FilterScreenState {
  const factory _Initial({Filter filter}) = _$_Initial;

  @override
  Filter get filter;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
