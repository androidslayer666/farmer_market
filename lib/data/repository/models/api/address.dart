import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'address.g.dart';

@JsonSerializable()
class Address extends Equatable {
  Address(
      {required this.userId,
      this.postal,
      this.house,
      this.country,
      this.longitude,
      this.latitude,
      this.city,
      this.region,
      this.street});

  String? userId;
  @JsonKey(name: 'postal_code')
  String? postal;
  String? country;
  String? region;
  String? city;
  String? street;
  String? house;
  @JsonKey(name: 'geo_lat')
  String? latitude;
  @JsonKey(name: 'geo_lon')
  String? longitude;

  @override
  String toString() {
    String str = '';
    if (region != null) str += region! + ', ';
    if (city != null) str += city! + ', ';
    if (street != null) str += street! + ', ';
    if (house != null) str += house! + ', ';
    return str;
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [
        userId,
        postal,
        country,
        region,
        city,
        street,
        house,
        latitude,
        longitude
      ];
}
