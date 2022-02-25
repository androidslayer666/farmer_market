import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_market/repository/address_repository/address_repository.dart';
import 'package:farmer_market/repository/models/api/address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../app/di/getit_setup.dart';
import '../constants.dart';
import '../models/product/product.dart';
import '../storage/storage_repository.dart';
import '../success_failure.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageRepository _storageRepository = locator<StorageRepository>();
  final AddressRepository _addressRepository = locator<AddressRepository>();

  Future<Result> saveProduct(Product product, Uint8List? file) async {
    try {
      final _currentUser = _auth.currentUser;

      if (file != null) {
        final result = await _storageRepository.uploadPictureToStorage(
            fireStoreNameProductPics, file);
        if (result is Success<String, String>) {
          product = product.copyWith(pictureUrl: result.data);
        }
      }

      if (_currentUser != null) {
        final address =
            await _addressRepository.getUserAddress(_currentUser.uid);
        product = product.copyWith(userID: _currentUser.uid);
        if (address is Success<Address, String>) {
          product = product.copyWith(address: address.data);
        }

        final jsonProduct = product.toJson();

        await _firestore
            .collection(fireStoreNameProductTable)
            .doc(Uuid().v1())
            .set(jsonProduct);
      }

      return Success();
    } catch (e) {
      return Failure();
    }
  }

  Future<Result<List<Product>, String>> getAllProducts() async {
    try {
      final listProducts =
          await _firestore.collection(fireStoreNameProductTable).get();
      return Success(
          data: (listProducts.docs
              .map((e) => Product.fromJson(e.data()))
              .toList()));
    } catch (e) {
      return Failure();
    }
  }

  Future<Result<List<Product>, String>> getUserProducts() async {
    final _currentUser = _auth.currentUser;
    try {
      final listProducts = await _firestore
          .collection(fireStoreNameProductTable)
          .where('userID', isEqualTo: _currentUser?.uid)
          .get();
      return Success(
          data: (listProducts.docs
              .map((e) => Product.fromJson(e.data()))
              .toList()));
    } catch (e) {
      return Failure();
    }
  }
}
