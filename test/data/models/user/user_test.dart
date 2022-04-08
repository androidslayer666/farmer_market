import 'package:farmer_market/data/models/convertors.dart';
import 'package:farmer_market/data/models/api/address.dart';
import 'package:farmer_market/data/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';

final user = User(
    name: 'name',
    description: 'description',
    reviews: ['123'],
    address: Address(
        userId: '123',
        city: 'London',
        latitude: '',
        longitude: '',
        country: '',
        house: '',
        postal: '',
        region: '',
        street: ''),
    phone: 'phone',
    isSeller: false,
    products: [],
    avatarUrl: 'avatarUrl');

final userJson = {
  'longitude': 1,
  'latitude': 1,
  'name': 'name',
  'description': 'description',
  'reviews': ['123'],
  'address': addressToJson(Address(
      userId: '123',
      city: 'London',
      latitude: '',
      longitude: '',
      country: '',
      house: '',
      postal: '',
      region: '',
      street: '')),
  'phone': 'phone',
  'isSeller': false,
  'product_repository': [],
  'avatarUrl': 'avatarUrl'
};


void main() {
  group('user model testing', () {
    test('get a correct json', () {
      expect(
          const DeepCollectionEquality().equals(user.toJson(), userJson), true);
    });
    test('get user from Json', () {
      expect(user.address == User.fromJson(userJson).address, true);
    });
  });
}