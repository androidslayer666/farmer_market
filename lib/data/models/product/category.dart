
import 'package:json_annotation/json_annotation.dart';

enum Category{
  @JsonValue("milk") milk,
  @JsonValue("meat") meat,
  @JsonValue("cheese") cheese
}