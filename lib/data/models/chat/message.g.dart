// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Initial _$$_InitialFromJson(Map<String, dynamic> json) => _$_Initial(
      id: json['id'] as String?,
      usedId: json['usedId'] as String?,
      message: json['message'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$_InitialToJson(_$_Initial instance) =>
    <String, dynamic>{
      'id': instance.id,
      'usedId': instance.usedId,
      'message': instance.message,
      'time': instance.time?.toIso8601String(),
    };
