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
    @Default(0) int portion,
    int? price,
    String? region,
    String? description,
    String? pictureUrl,
    @JsonKey(fromJson: categoryFromJson, toJson: categoryToJson)
    Category? category,
    // ignore: invalid_annotation_target
    @JsonKey(fromJson: addressFromJson, toJson: addressToJson) Address? address,
    List<Review>? reviews,
    @Default([]) List<Address> shippingAddresses,
    String? userID,
    DateTime? nextPossibleShipping
  }) = _Initial;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
