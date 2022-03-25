import 'package:freezed_annotation/freezed_annotation.dart';

import '../convertors.dart';
import '../api/address.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? id,
    String? name,
    String? phone,
    String? description,
    bool? isSeller,
    double? longitude,
    double? latitude,
    String? avatarUrl,
    // ignore: invalid_annotation_target
    @JsonKey(fromJson: addressFromJson, toJson: addressToJson) Address? address,
    List<String>? products,
    List<String>? orders,
    List<String>? reviews,
  }) = _Initial;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
