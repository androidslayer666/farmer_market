// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      userID: json['userID'] as String,
      unit: $enumDecode(_$UnitEnumMap, json['unit']),
      description: json['description'] as String?,
      price: json['price'] as int?,
      pictureUrl: json['pictureUrl'] as String?,
      reviews:
          (json['reviews'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'unit': _$UnitEnumMap[instance.unit],
      'price': instance.price,
      'description': instance.description,
      'pictureUrl': instance.pictureUrl,
      'reviews': instance.reviews,
      'userID': instance.userID,
    };

const _$UnitEnumMap = {
  Unit.litres: 'litres',
  Unit.kilos: 'kilos',
};
