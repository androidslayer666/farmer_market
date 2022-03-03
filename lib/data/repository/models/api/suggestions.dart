import 'package:farmer_market/data/repository/models/api/suggestion.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suggestions.g.dart';

@JsonSerializable()
class Suggestions {
  List<Suggestion>? suggestions;

  Suggestions({this.suggestions});

  factory Suggestions.fromJson(Map<String, dynamic> json) =>
      _$SuggestionsFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestionsToJson(this);
}
