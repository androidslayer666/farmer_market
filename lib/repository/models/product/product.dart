import 'package:freezed_annotation/freezed_annotation.dart';

import '../addressConvertors.dart';
import '../api/address.dart';

part 'product.freezed.dart';

part 'product.g.dart';

enum Unit { litres, kilos }

@freezed
class Product with _$Product {
  const factory Product({
    String? name,
    Unit? unit,
    int? price,
    String? description,
    String? pictureUrl,
    // ignore: invalid_annotation_target
    @JsonKey(fromJson: addressFromJson, toJson: addressToJson) Address? address,
    List<String>? reviews,
    String? userID,
  }) = _Initial;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
