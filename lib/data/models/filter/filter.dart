import 'package:freezed_annotation/freezed_annotation.dart';

import '../convertors.dart';
import '../product/category.dart';

part 'filter.freezed.dart';

part 'filter.g.dart';

@freezed
class Filter with _$Filter {
  const Filter._();

  const factory Filter({
    @JsonKey(toJson: listCategoriesToJson, fromJson: listCategoriesFromJson)
        List<Category>? categories,
    int? topPrice,
    int? bottomPrice,
  }) = _Initial;

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  bool isEmpty() {
    return (categories == null || categories?.isEmpty == true) &&
        topPrice == null &&
        bottomPrice == null;
  }
}
