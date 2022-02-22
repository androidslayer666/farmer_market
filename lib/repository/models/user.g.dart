// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      isSeller: json['isSeller'] as bool,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      avatarUrl: json['avatarUrl'] as String?,
      address: User._addressFromJson(json['address'] as Map<String, dynamic>?),
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
      'address': User._addressToJson(instance.address),
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'products': instance.products,
      'reviews': instance.reviews,
    };
