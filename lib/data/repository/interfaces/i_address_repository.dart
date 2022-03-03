import '../models/api/address.dart';
import '../models/api/suggestion.dart';
import '../success_failure.dart';

abstract class IAddressRepository {
  Future<Result<List<Suggestion>, String>> getSuggestions(String query);
  Future<Result> saveAddress(Address address);
  Future<Result<Address, String>> getUserAddress(String userId);
}