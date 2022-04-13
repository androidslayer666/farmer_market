// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../convertors.dart';
import '../api/address.dart';
import '../review/review.dart';
import 'category.dart';

part 'product.freezed.dart';

part 'product.g.dart';

enum Unit { litres, kilos, grams }

@freezed
class Product with _$Product {
  const factory Product({
    String? id,
    String? name,
    Unit? unit,
    int? portion,
    int? price,
    String? region,
    String? description,
    String? pictureUrl,
    @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
    Category? category,
    @JsonKey(fromJson: addressFromJson, toJson: addressToJson)
    Address? address,
    @JsonKey(toJson: listReviewsToJson)
    List<Review>? reviews,
    @Default([]) List<Address> shippingAddresses,
    String? userID,
    DateTime? nextPossibleShipping
  }) = _Initial;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
