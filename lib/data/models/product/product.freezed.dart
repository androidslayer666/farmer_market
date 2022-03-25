// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Initial.fromJson(json);
}

/// @nodoc
class _$ProductTearOff {
  const _$ProductTearOff();

  _Initial call(
      {String? id,
      String? name,
      Unit? unit,
      int? price,
      String? description,
      String? pictureUrl,
      @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
          Category? category,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? reviews,
      String? userID,
      DateTime? nextPossibleShipping}) {
    return _Initial(
      id: id,
      name: name,
      unit: unit,
      price: price,
      description: description,
      pictureUrl: pictureUrl,
      category: category,
      address: address,
      reviews: reviews,
      userID: userID,
      nextPossibleShipping: nextPossibleShipping,
    );
  }

  Product fromJson(Map<String, Object?> json) {
    return Product.fromJson(json);
  }
}

/// @nodoc
const $Product = _$ProductTearOff();

/// @nodoc
mixin _$Product {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  Unit? get unit => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get pictureUrl => throw _privateConstructorUsedError;
  @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
  Category? get category =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
  Address? get address => throw _privateConstructorUsedError;
  List<String>? get reviews => throw _privateConstructorUsedError;
  String? get userID => throw _privateConstructorUsedError;
  DateTime? get nextPossibleShipping => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? name,
      Unit? unit,
      int? price,
      String? description,
      String? pictureUrl,
      @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
          Category? category,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? reviews,
      String? userID,
      DateTime? nextPossibleShipping});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  final Product _value;
  // ignore: unused_field
  final $Res Function(Product) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? unit = freezed,
    Object? price = freezed,
    Object? description = freezed,
    Object? pictureUrl = freezed,
    Object? category = freezed,
    Object? address = freezed,
    Object? reviews = freezed,
    Object? userID = freezed,
    Object? nextPossibleShipping = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureUrl: pictureUrl == freezed
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      reviews: reviews == freezed
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userID: userID == freezed
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String?,
      nextPossibleShipping: nextPossibleShipping == freezed
          ? _value.nextPossibleShipping
          : nextPossibleShipping // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? name,
      Unit? unit,
      int? price,
      String? description,
      String? pictureUrl,
      @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
          Category? category,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? reviews,
      String? userID,
      DateTime? nextPossibleShipping});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$ProductCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? unit = freezed,
    Object? price = freezed,
    Object? description = freezed,
    Object? pictureUrl = freezed,
    Object? category = freezed,
    Object? address = freezed,
    Object? reviews = freezed,
    Object? userID = freezed,
    Object? nextPossibleShipping = freezed,
  }) {
    return _then(_Initial(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureUrl: pictureUrl == freezed
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      reviews: reviews == freezed
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userID: userID == freezed
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String?,
      nextPossibleShipping: nextPossibleShipping == freezed
          ? _value.nextPossibleShipping
          : nextPossibleShipping // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Initial implements _Initial {
  const _$_Initial(
      {this.id,
      this.name,
      this.unit,
      this.price,
      this.description,
      this.pictureUrl,
      @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
          this.category,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          this.address,
      this.reviews,
      this.userID,
      this.nextPossibleShipping});

  factory _$_Initial.fromJson(Map<String, dynamic> json) =>
      _$$_InitialFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final Unit? unit;
  @override
  final int? price;
  @override
  final String? description;
  @override
  final String? pictureUrl;
  @override
  @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
  final Category? category;
  @override // ignore: invalid_annotation_target
  @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
  final Address? address;
  @override
  final List<String>? reviews;
  @override
  final String? userID;
  @override
  final DateTime? nextPossibleShipping;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, unit: $unit, price: $price, description: $description, pictureUrl: $pictureUrl, category: $category, address: $address, reviews: $reviews, userID: $userID, nextPossibleShipping: $nextPossibleShipping)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.unit, unit) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.pictureUrl, pictureUrl) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.reviews, reviews) &&
            const DeepCollectionEquality().equals(other.userID, userID) &&
            const DeepCollectionEquality()
                .equals(other.nextPossibleShipping, nextPossibleShipping));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(unit),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(pictureUrl),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(reviews),
      const DeepCollectionEquality().hash(userID),
      const DeepCollectionEquality().hash(nextPossibleShipping));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InitialToJson(this);
  }
}

abstract class _Initial implements Product {
  const factory _Initial(
      {String? id,
      String? name,
      Unit? unit,
      int? price,
      String? description,
      String? pictureUrl,
      @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
          Category? category,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? reviews,
      String? userID,
      DateTime? nextPossibleShipping}) = _$_Initial;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$_Initial.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  Unit? get unit;
  @override
  int? get price;
  @override
  String? get description;
  @override
  String? get pictureUrl;
  @override
  @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
  Category? get category;
  @override // ignore: invalid_annotation_target
  @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
  Address? get address;
  @override
  List<String>? get reviews;
  @override
  String? get userID;
  @override
  DateTime? get nextPossibleShipping;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
