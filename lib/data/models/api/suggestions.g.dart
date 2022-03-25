// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suggestions _$SuggestionsFromJson(Map<String, dynamic> json) => Suggestions(
      suggestions: (json['suggestions'] as List<dynamic>?)
          ?.map((e) => Suggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuggestionsToJson(Suggestions instance) =>
    <String, dynamic>{
      'suggestions': instance.suggestions,
    };
