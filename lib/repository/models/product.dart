import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

enum Unit {litres, kilos}

@JsonSerializable()
class Product {
  String name;
  Unit unit;
  int? price;
  String? description;
  String? pictureUrl;
  List<String>? reviews;
  String userID;

  Product({
    required this.name,
    required this.userID,
    required this.unit,
    required this.description,
    this.price,
    this.pictureUrl,
    this.reviews,
  });


  @override
  String toString() {
    return 'name : $name ;;; unit: $unit ;;; description $description';
  }

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

}