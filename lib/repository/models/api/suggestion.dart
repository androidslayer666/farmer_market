import 'package:farmer_market/repository/models/api/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suggestion.g.dart';

@JsonSerializable()
class Suggestion {
  Suggestion(
      {required this.value,
        required this.data
      });
  @JsonValue('value')
  String value;
  @JsonValue('data')
  Address data;

  @override
  String toString() {
    return '$value $data';
  }

  factory Suggestion.fromJson(Map<String, dynamic> json) =>
      _$SuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestionToJson(this);
}
