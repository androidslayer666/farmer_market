// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      userId: json['userId'] as String?,
      postal: json['postal_code'] as String?,
      house: json['house'] as String?,
      country: json['country'] as String?,
      longitude: json['geo_lon'] as String?,
      latitude: json['geo_lat'] as String?,
      city: json['city'] as String?,
      region: json['region'] as String?,
      street: json['street'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'userId': instance.userId,
      'postal_code': instance.postal,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'street': instance.street,
      'house': instance.house,
      'geo_lat': instance.latitude,
      'geo_lon': instance.longitude,
    };
