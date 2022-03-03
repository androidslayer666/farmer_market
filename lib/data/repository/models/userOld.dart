// import 'dart:convert';
// import 'dart:ffi';
//
// import 'package:equatable/equatable.dart';
// import 'package:farmer_market/repository/models/user.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// import 'api/address.dart';
//
// part 'user.g.dart';
//
// @JsonSerializable()
// class User extends Equatable {
//   String name;
//   final String? phone;
//   final String? description;
//   final bool isSeller;
//   final String? avatarUrl;
//   @JsonKey(fromJson: _addressFromJson, toJson: _addressToJson)
//   final Address? address;
//   final double? longitude;
//   final double? latitude;
//   final List<String>? products;
//   final List<String>? reviews;
//
//   User({
//     required this.name,
//     this.phone,
//     required this.description,
//     required this.isSeller,
//     this.longitude,
//     this.latitude,
//     this.avatarUrl,
//     this.address,
//     this.products,
//     this.reviews,
//   });
//
//
//
//   @override
//   String toString() {
//     return 'name : $name ;;; phone: $phone ;;; description $description ;;; address: $address';
//   }
//
//   static Map<String, dynamic>? _addressToJson(Address? address) =>
//       address?.toJson();
//
//   static Address _addressFromJson(Map<String, dynamic>? json) =>
//       Address.fromJson(json ?? {});
//
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserToJson(this);
//
//   @override
//   List<Object?> get props => [
//         name,
//         phone,
//         description,
//         address,
//         latitude,
//         longitude,
//         isSeller,
//         avatarUrl,
//         products,
//         reviews
//       ];
// }
