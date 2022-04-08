// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product_detail_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProductDetailStateTearOff {
  const _$ProductDetailStateTearOff();

  _Initial call(
      {User? user,
      Product? product,
      bool? problemWithFetchingUser,
      Review review = const Review(),
      bool showReview = false}) {
    return _Initial(
      user: user,
      product: product,
      problemWithFetchingUser: problemWithFetchingUser,
      review: review,
      showReview: showReview,
    );
  }
}

/// @nodoc
const $ProductDetailState = _$ProductDetailStateTearOff();

/// @nodoc
mixin _$ProductDetailState {
  User? get user => throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;
  bool? get problemWithFetchingUser => throw _privateConstructorUsedError;
  Review get review => throw _privateConstructorUsedError;
  bool get showReview => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductDetailStateCopyWith<ProductDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailStateCopyWith(
          ProductDetailState value, $Res Function(ProductDetailState) then) =
      _$ProductDetailStateCopyWithImpl<$Res>;
  $Res call(
      {User? user,
      Product? product,
      bool? problemWithFetchingUser,
      Review review,
      bool showReview});

  $UserCopyWith<$Res>? get user;
  $ProductCopyWith<$Res>? get product;
  $ReviewCopyWith<$Res> get review;
}

/// @nodoc
class _$ProductDetailStateCopyWithImpl<$Res>
    implements $ProductDetailStateCopyWith<$Res> {
  _$ProductDetailStateCopyWithImpl(this._value, this._then);

  final ProductDetailState _value;
  // ignore: unused_field
  final $Res Function(ProductDetailState) _then;

  @override
  $Res call({
    Object? user = freezed,
    Object? product = freezed,
    Object? problemWithFetchingUser = freezed,
    Object? review = freezed,
    Object? showReview = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      problemWithFetchingUser: problemWithFetchingUser == freezed
          ? _value.problemWithFetchingUser
          : problemWithFetchingUser // ignore: cast_nullable_to_non_nullable
              as bool?,
      review: review == freezed
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as Review,
      showReview: showReview == freezed
          ? _value.showReview
          : showReview // ignore: cast_nullable_to_non_nullable
              as bool,
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

  @override
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value));
    });
  }

  @override
  $ReviewCopyWith<$Res> get review {
    return $ReviewCopyWith<$Res>(_value.review, (value) {
      return _then(_value.copyWith(review: value));
    });
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $ProductDetailStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {User? user,
      Product? product,
      bool? problemWithFetchingUser,
      Review review,
      bool showReview});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $ProductCopyWith<$Res>? get product;
  @override
  $ReviewCopyWith<$Res> get review;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$ProductDetailStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? user = freezed,
    Object? product = freezed,
    Object? problemWithFetchingUser = freezed,
    Object? review = freezed,
    Object? showReview = freezed,
  }) {
    return _then(_Initial(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      problemWithFetchingUser: problemWithFetchingUser == freezed
          ? _value.problemWithFetchingUser
          : problemWithFetchingUser // ignore: cast_nullable_to_non_nullable
              as bool?,
      review: review == freezed
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as Review,
      showReview: showReview == freezed
          ? _value.showReview
          : showReview // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.user,
      this.product,
      this.problemWithFetchingUser,
      this.review = const Review(),
      this.showReview = false});

  @override
  final User? user;
  @override
  final Product? product;
  @override
  final bool? problemWithFetchingUser;
  @JsonKey()
  @override
  final Review review;
  @JsonKey()
  @override
  final bool showReview;

  @override
  String toString() {
    return 'ProductDetailState(user: $user, product: $product, problemWithFetchingUser: $problemWithFetchingUser, review: $review, showReview: $showReview)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other.product, product) &&
            const DeepCollectionEquality().equals(
                other.problemWithFetchingUser, problemWithFetchingUser) &&
            const DeepCollectionEquality().equals(other.review, review) &&
            const DeepCollectionEquality()
                .equals(other.showReview, showReview));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(product),
      const DeepCollectionEquality().hash(problemWithFetchingUser),
      const DeepCollectionEquality().hash(review),
      const DeepCollectionEquality().hash(showReview));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements ProductDetailState {
  const factory _Initial(
      {User? user,
      Product? product,
      bool? problemWithFetchingUser,
      Review review,
      bool showReview}) = _$_Initial;

  @override
  User? get user;
  @override
  Product? get product;
  @override
  bool? get problemWithFetchingUser;
  @override
  Review get review;
  @override
  bool get showReview;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
