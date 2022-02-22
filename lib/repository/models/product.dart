import 'package:json_annotation/json_annotation.dart';

import 'api/address.dart';

part 'product.g.dart';

enum Unit {litres, kilos}

@JsonSerializable()
class Product {
  String name;
  Unit unit;
  int? price;
  String? description;
  String? pictureUrl;
  @JsonKey(fromJson: _addressFromJson, toJson: _addressToJson)
  Address? address;
  List<String>? reviews;
  String userID;

  Product({
    required this.name,
    required this.userID,
    required this.unit,
    required this.description,
    this.address,
    this.price,
    this.pictureUrl,
    this.reviews,
  });


  @override
  String toString() {
    return 'name : $name ;;; unit: $unit ;;; description $description';
  }

  static Map<String, dynamic>? _addressToJson(Address? address) => address?.toJson();
  static Address _addressFromJson(Map<String, dynamic>? json) => Address.fromJson(json?? {});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

}