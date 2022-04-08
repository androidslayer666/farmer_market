import 'package:collection/collection.dart';
import 'package:farmer_market/data/models/convertors.dart';
import 'package:farmer_market/data/models/api/address.dart';
import 'package:farmer_market/data/models/product/product.dart';
import 'package:farmer_market/data/models/review/review.dart';
import 'package:flutter_test/flutter_test.dart';

final productJson = {
  'name': 'instance.name',
  'unit': 'litres',
  'price': 10,
  'description': 'instance.description',
  'pictureUrl': 'instance.pictureUrl',
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
  'reviews': ['123'],
  'userID': 'instance.userID'
};

final product = Product(
  name: 'instance.name',
  unit: Unit.litres,
  price: 10,
  description: 'instance.description',
  pictureUrl: 'instance.pictureUrl',
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
  userID: 'instance.userID',
  reviews: [Review()],
);

void main() {
  group('product model testing', () {
    test('get a correct json', () {
      expect(
          const DeepCollectionEquality().equals(product.toJson(), productJson), true);
    });
    test('get product from Json', () {
      expect(product.address == Product.fromJson(productJson).address, true);
    });
  });
}
