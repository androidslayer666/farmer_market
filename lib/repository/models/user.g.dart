// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      phone: json['phone'] as String,
      description: json['description'] as String?,
      isSeller: json['isSeller'] as bool,
      avatarUrl: json['avatarUrl'] as String?,
      address: json['address'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      reviews:
          (json['reviews'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'description': instance.description,
      'isSeller': instance.isSeller,
      'avatarUrl': instance.avatarUrl,
      'address': instance.address,
      'products': instance.products,
      'reviews': instance.reviews,
    };
