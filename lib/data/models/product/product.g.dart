// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Initial _$$_InitialFromJson(Map<String, dynamic> json) => _$_Initial(
      id: json['id'] as String?,
      name: json['name'] as String?,
      unit: $enumDecodeNullable(_$UnitEnumMap, json['unit']),
      portion: json['portion'] as int? ?? 0,
      price: json['price'] as int?,
      region: json['region'] as String?,
      description: json['description'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
      category: categoryFromJson(json['category'] as String?),
      address: addressFromJson(json['address'] as Map<String, dynamic>?),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingAddresses: (json['shippingAddresses'] as List<dynamic>?)
              ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      userID: json['userID'] as String?,
      nextPossibleShipping: json['nextPossibleShipping'] == null
          ? null
          : DateTime.parse(json['nextPossibleShipping'] as String),
    );

Map<String, dynamic> _$$_InitialToJson(_$_Initial instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': _$UnitEnumMap[instance.unit],
      'portion': instance.portion,
      'price': instance.price,
      'region': instance.region,
      'description': instance.description,
      'pictureUrl': instance.pictureUrl,
      'category': categoryToJson(instance.category),
      'address': addressToJson(instance.address),
      'reviews': instance.reviews,
      'shippingAddresses': instance.shippingAddresses,
      'userID': instance.userID,
      'nextPossibleShipping': instance.nextPossibleShipping?.toIso8601String(),
    };

const _$UnitEnumMap = {
  Unit.litres: 'litres',
  Unit.kilos: 'kilos',
  Unit.grams: 'grams',
};
