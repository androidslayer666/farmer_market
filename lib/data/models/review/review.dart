import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';

part 'review.g.dart';

@freezed
class Review with _$Review{
  const factory Review({
    String? message,
    double? rate
}) = _Initial;

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);
}