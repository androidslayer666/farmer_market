
import 'api/address.dart';

Address? addressFromJson(Map<String, dynamic>? json) => json != null ? Address.fromJson(json) : null;
Map<String, dynamic>? addressToJson(Address? address) => address?.toJson();
