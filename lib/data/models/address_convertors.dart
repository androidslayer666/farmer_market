
import 'api/address.dart';

// the functions that is just redirecting to correct json convertors
Address? addressFromJson(Map<String, dynamic>? json) => json != null ? Address.fromJson(json) : null;
Map<String, dynamic>? addressToJson(Address? address) => address?.toJson();
