// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Initial _$$_InitialFromJson(Map<String, dynamic> json) => _$_Initial(
      categories: listCategoriesFromJson(json['categories'] as List<String>?),
      topPrice: json['topPrice'] as int?,
      bottomPrice: json['bottomPrice'] as int?,
    );

Map<String, dynamic> _$$_InitialToJson(_$_Initial instance) =>
    <String, dynamic>{
      'categories': listCategoriesToJson(instance.categories),
      'topPrice': instance.topPrice,
      'bottomPrice': instance.bottomPrice,
    };
