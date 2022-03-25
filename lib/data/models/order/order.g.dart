// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Initial _$$_InitialFromJson(Map<String, dynamic> json) => _$_Initial(
      id: json['id'] as String?,
      shipperId: json['shipperId'] as String?,
      purchaserId: json['purchaserId'] as String?,
      cartItems: (json['cartItems'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      confirmedShippingDate: json['confirmedShippingDate'] == null
          ? null
          : DateTime.parse(json['confirmedShippingDate'] as String),
      dateCreated: json['dateCreated'] == null
          ? null
          : DateTime.parse(json['dateCreated'] as String),
    );

Map<String, dynamic> _$$_InitialToJson(_$_Initial instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shipperId': instance.shipperId,
      'purchaserId': instance.purchaserId,
      'cartItems': listCartItemsToJson(instance.cartItems),
      'confirmedShippingDate':
          instance.confirmedShippingDate?.toIso8601String(),
      'dateCreated': instance.dateCreated?.toIso8601String(),
    };
