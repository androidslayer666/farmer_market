// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _Initial.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _Initial call(
      {String? name,
      String? phone,
      String? description,
      bool? isSeller,
      double? longitude,
      double? latitude,
      String? avatarUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? products,
      List<String>? reviews}) {
    return _Initial(
      name: name,
      phone: phone,
      description: description,
      isSeller: isSeller,
      longitude: longitude,
      latitude: latitude,
      avatarUrl: avatarUrl,
      address: address,
      products: products,
      reviews: reviews,
    );
  }

  User fromJson(Map<String, Object?> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool? get isSeller => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  String? get avatarUrl =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
  Address? get address => throw _privateConstructorUsedError;
  List<String>? get products => throw _privateConstructorUsedError;
  List<String>? get reviews => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String? name,
      String? phone,
      String? description,
      bool? isSeller,
      double? longitude,
      double? latitude,
      String? avatarUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? products,
      List<String>? reviews});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? phone = freezed,
    Object? description = freezed,
    Object? isSeller = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? avatarUrl = freezed,
    Object? address = freezed,
    Object? products = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isSeller: isSeller == freezed
          ? _value.isSeller
          : isSeller // ignore: cast_nullable_to_non_nullable
              as bool?,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      reviews: reviews == freezed
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? name,
      String? phone,
      String? description,
      bool? isSeller,
      double? longitude,
      double? latitude,
      String? avatarUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? products,
      List<String>? reviews});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? name = freezed,
    Object? phone = freezed,
    Object? description = freezed,
    Object? isSeller = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? avatarUrl = freezed,
    Object? address = freezed,
    Object? products = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_Initial(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isSeller: isSeller == freezed
          ? _value.isSeller
          : isSeller // ignore: cast_nullable_to_non_nullable
              as bool?,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      reviews: reviews == freezed
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Initial implements _Initial {
  const _$_Initial(
      {this.name,
      this.phone,
      this.description,
      this.isSeller,
      this.longitude,
      this.latitude,
      this.avatarUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson) this.address,
      this.products,
      this.reviews});

  factory _$_Initial.fromJson(Map<String, dynamic> json) =>
      _$$_InitialFromJson(json);

  @override
  final String? name;
  @override
  final String? phone;
  @override
  final String? description;
  @override
  final bool? isSeller;
  @override
  final double? longitude;
  @override
  final double? latitude;
  @override
  final String? avatarUrl;
  @override // ignore: invalid_annotation_target
  @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
  final Address? address;
  @override
  final List<String>? products;
  @override
  final List<String>? reviews;

  @override
  String toString() {
    return 'User(name: $name, phone: $phone, description: $description, isSeller: $isSeller, longitude: $longitude, latitude: $latitude, avatarUrl: $avatarUrl, address: $address, products: $products, reviews: $reviews)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.isSeller, isSeller) &&
            const DeepCollectionEquality().equals(other.longitude, longitude) &&
            const DeepCollectionEquality().equals(other.latitude, latitude) &&
            const DeepCollectionEquality().equals(other.avatarUrl, avatarUrl) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.products, products) &&
            const DeepCollectionEquality().equals(other.reviews, reviews));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(isSeller),
      const DeepCollectionEquality().hash(longitude),
      const DeepCollectionEquality().hash(latitude),
      const DeepCollectionEquality().hash(avatarUrl),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(products),
      const DeepCollectionEquality().hash(reviews));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InitialToJson(this);
  }
}

abstract class _Initial implements User {
  const factory _Initial(
      {String? name,
      String? phone,
      String? description,
      bool? isSeller,
      double? longitude,
      double? latitude,
      String? avatarUrl,
      @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
          Address? address,
      List<String>? products,
      List<String>? reviews}) = _$_Initial;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$_Initial.fromJson;

  @override
  String? get name;
  @override
  String? get phone;
  @override
  String? get description;
  @override
  bool? get isSeller;
  @override
  double? get longitude;
  @override
  double? get latitude;
  @override
  String? get avatarUrl;
  @override // ignore: invalid_annotation_target
  @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
  Address? get address;
  @override
  List<String>? get products;
  @override
  List<String>? get reviews;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}