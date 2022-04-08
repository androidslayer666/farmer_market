// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Initial _$$_InitialFromJson(Map<String, dynamic> json) => _$_Initial(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      isSeller: json['isSeller'] as bool?,
      avatarUrl: json['avatarUrl'] as String?,
      address: addressFromJson(json['address'] as Map<String, dynamic>?),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orders:
          (json['orders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      reviews:
          (json['reviews'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_InitialToJson(_$_Initial instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'description': instance.description,
      'isSeller': instance.isSeller,
      'avatarUrl': instance.avatarUrl,
      'address': addressToJson(instance.address),
      'products': instance.products,
      'orders': instance.orders,
      'reviews': instance.reviews,
    };
