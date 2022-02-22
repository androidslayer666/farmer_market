import 'dart:convert';
import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import 'api/address.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;
  String? phone;
  String? description;
  bool isSeller;
  String? avatarUrl;
  @JsonKey(fromJson: _addressFromJson, toJson: _addressToJson)
  Address? address;
  double? longitude;
  double? latitude;
  List<String>? products;
  List<String>? reviews;

  User({
    required this.name,
    this.phone,
    required this.description,
    required this.isSeller,
    this.longitude,
    this.latitude,
    this.avatarUrl,
    this.address,
    this.products,
    this.reviews,
  });


  @override
  String toString() {
    return 'name : $name ;;; phone: $phone ;;; description $description ;;; address: $address';
  }

  static Map<String, dynamic>? _addressToJson(Address? address) => address?.toJson();
  static Address _addressFromJson(Map<String, dynamic>? json) => Address.fromJson(json?? {});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}