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
      {String? name,
      Unit? unit,
      int? price,
      String? description,
      String? pictureUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? reviews,
      String? userID}) {
    return _Initial(
      name: name,
      unit: unit,
      price: price,
      description: description,
      pictureUrl: pictureUrl,
      address: address,
      reviews: reviews,
      userID: userID,
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
  String? get name => throw _privateConstructorUsedError;
  Unit? get unit => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get pictureUrl =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
  Address? get address => throw _privateConstructorUsedError;
  List<String>? get reviews => throw _privateConstructorUsedError;
  String? get userID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res>;
  $Res call(
      {String? name,
      Unit? unit,
      int? price,
      String? description,
      String? pictureUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? reviews,
      String? userID});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  final Product _value;
  // ignore: unused_field
  final $Res Function(Product) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? unit = freezed,
    Object? price = freezed,
    Object? description = freezed,
    Object? pictureUrl = freezed,
    Object? address = freezed,
    Object? reviews = freezed,
    Object? userID = freezed,
  }) {
    return _then(_value.copyWith(
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
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? name,
      Unit? unit,
      int? price,
      String? description,
      String? pictureUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? reviews,
      String? userID});
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
    Object? name = freezed,
    Object? unit = freezed,
    Object? price = freezed,
    Object? description = freezed,
    Object? pictureUrl = freezed,
    Object? address = freezed,
    Object? reviews = freezed,
    Object? userID = freezed,
  }) {
    return _then(_Initial(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Initial implements _Initial {
  const _$_Initial(
      {this.name,
      this.unit,
      this.price,
      this.description,
      this.pictureUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson) this.address,
      this.reviews,
      this.userID});

  factory _$_Initial.fromJson(Map<String, dynamic> json) =>
      _$$_InitialFromJson(json);

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
  @override // ignore: invalid_annotation_target
  @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
  final Address? address;
  @override
  final List<String>? reviews;
  @override
  final String? userID;

  @override
  String toString() {
    return 'Product(name: $name, unit: $unit, price: $price, description: $description, pictureUrl: $pictureUrl, address: $address, reviews: $reviews, userID: $userID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.unit, unit) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.pictureUrl, pictureUrl) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.reviews, reviews) &&
            const DeepCollectionEquality().equals(other.userID, userID));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(unit),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(pictureUrl),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(reviews),
      const DeepCollectionEquality().hash(userID));

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
      {String? name,
      Unit? unit,
      int? price,
      String? description,
      String? pictureUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? reviews,
      String? userID}) = _$_Initial;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$_Initial.fromJson;

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
  @override // ignore: invalid_annotation_target
  @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
  Address? get address;
  @override
  List<String>? get reviews;
  @override
  String? get userID;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
