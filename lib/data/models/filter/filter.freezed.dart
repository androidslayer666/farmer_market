// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return _Initial.fromJson(json);
}

/// @nodoc
class _$FilterTearOff {
  const _$FilterTearOff();

  _Initial call(
      {@JsonKey(toJson: listCategoriesToJson, fromJson: listCategoriesFromJson)
          List<Category>? categories,
      int? topPrice,
      int? bottomPrice}) {
    return _Initial(
      categories: categories,
      topPrice: topPrice,
      bottomPrice: bottomPrice,
    );
  }

  Filter fromJson(Map<String, Object?> json) {
    return Filter.fromJson(json);
  }
}

/// @nodoc
const $Filter = _$FilterTearOff();

/// @nodoc
mixin _$Filter {
  @JsonKey(toJson: listCategoriesToJson, fromJson: listCategoriesFromJson)
  List<Category>? get categories => throw _privateConstructorUsedError;
  int? get topPrice => throw _privateConstructorUsedError;
  int? get bottomPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterCopyWith<Filter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterCopyWith<$Res> {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) then) =
      _$FilterCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(toJson: listCategoriesToJson, fromJson: listCategoriesFromJson)
          List<Category>? categories,
      int? topPrice,
      int? bottomPrice});
}

/// @nodoc
class _$FilterCopyWithImpl<$Res> implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._value, this._then);

  final Filter _value;
  // ignore: unused_field
  final $Res Function(Filter) _then;

  @override
  $Res call({
    Object? categories = freezed,
    Object? topPrice = freezed,
    Object? bottomPrice = freezed,
  }) {
    return _then(_value.copyWith(
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>?,
      topPrice: topPrice == freezed
          ? _value.topPrice
          : topPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      bottomPrice: bottomPrice == freezed
          ? _value.bottomPrice
          : bottomPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(toJson: listCategoriesToJson, fromJson: listCategoriesFromJson)
          List<Category>? categories,
      int? topPrice,
      int? bottomPrice});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? categories = freezed,
    Object? topPrice = freezed,
    Object? bottomPrice = freezed,
  }) {
    return _then(_Initial(
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>?,
      topPrice: topPrice == freezed
          ? _value.topPrice
          : topPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      bottomPrice: bottomPrice == freezed
          ? _value.bottomPrice
          : bottomPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Initial extends _Initial {
  const _$_Initial(
      {@JsonKey(toJson: listCategoriesToJson, fromJson: listCategoriesFromJson)
          this.categories,
      this.topPrice,
      this.bottomPrice})
      : super._();

  factory _$_Initial.fromJson(Map<String, dynamic> json) =>
      _$$_InitialFromJson(json);

  @override
  @JsonKey(toJson: listCategoriesToJson, fromJson: listCategoriesFromJson)
  final List<Category>? categories;
  @override
  final int? topPrice;
  @override
  final int? bottomPrice;

  @override
  String toString() {
    return 'Filter(categories: $categories, topPrice: $topPrice, bottomPrice: $bottomPrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            const DeepCollectionEquality().equals(other.topPrice, topPrice) &&
            const DeepCollectionEquality()
                .equals(other.bottomPrice, bottomPrice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(categories),
      const DeepCollectionEquality().hash(topPrice),
      const DeepCollectionEquality().hash(bottomPrice));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InitialToJson(this);
  }
}

abstract class _Initial extends Filter {
  const factory _Initial(
      {@JsonKey(toJson: listCategoriesToJson, fromJson: listCategoriesFromJson)
          List<Category>? categories,
      int? topPrice,
      int? bottomPrice}) = _$_Initial;
  const _Initial._() : super._();

  factory _Initial.fromJson(Map<String, dynamic> json) = _$_Initial.fromJson;

  @override
  @JsonKey(toJson: listCategoriesToJson, fromJson: listCategoriesFromJson)
  List<Category>? get categories;
  @override
  int? get topPrice;
  @override
  int? get bottomPrice;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
