// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Initial _$$_InitialFromJson(Map<String, dynamic> json) => _$_Initial(
      id: json['id'] as String?,
      name: json['name'] as String?,
      unit: $enumDecodeNullable(_$UnitEnumMap, json['unit']),
      price: json['price'] as int?,
      description: json['description'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
      address: addressFromJson(json['address'] as Map<String, dynamic>?),
      reviews:
          (json['reviews'] as List<dynamic>?)?.map((e) => e as String).toList(),
      userID: json['userID'] as String?,
    );

Map<String, dynamic> _$$_InitialToJson(_$_Initial instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': _$UnitEnumMap[instance.unit],
      'price': instance.price,
      'description': instance.description,
      'pictureUrl': instance.pictureUrl,
      'address': addressToJson(instance.address),
      'reviews': instance.reviews,
      'userID': instance.userID,
    };

const _$UnitEnumMap = {
  Unit.litres: 'litres',
  Unit.kilos: 'kilos',
};
