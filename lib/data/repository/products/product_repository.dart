import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../models/api/address.dart';
import '../constants.dart';
import '../interfaces/i_address_repository.dart';
import '../../models/product/product.dart';
import '../storage/storage_repository.dart';
import '../success_failure.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final StorageRepository _storageRepository;
  final IAddressRepository _addressRepository;

  ProductRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required StorageRepository storageRepository,
      required IAddressRepository addressRepository})
      : _firestore = firestore,
        _auth = auth,
        _storageRepository = storageRepository,
        _addressRepository = addressRepository;

  Future<Result> saveProduct(Product product, Uint8List? file) async {
    try {
      final _currentUser = _auth.currentUser;

      if (file != null && product.pictureUrl == null) {
        print("file != null");
        final result = await _storageRepository.uploadPictureToStorage(
            fireStoreNameProductPics, file);
        if (result is Success<String, String>) {
          product = product.copyWith(pictureUrl: result.data);
        }
      }

      if (_currentUser != null) {
        print("_currentUser != null");
        final address =
            await _addressRepository.getUserAddress(_currentUser.uid);
        product = product.copyWith(userID: _currentUser.uid);
        if (address is Success<Address, String>) {
          product = product.copyWith(address: address.data);
        }

        if(product.id == null) {
          product = product.copyWith(id: const Uuid().v1());
        }

        final jsonProduct = product.toJson();

        await _firestore
            .collection(fireStoreNameProductTable)
            .doc(product.id)
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
      // print(listProducts.docs
      //     .map((e) => Product.fromJson(e.data()))
      //     .toList());
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

  Future<Result> deleteProducts(String productUid) async {
    try{
      await _firestore
          .collection(fireStoreNameProductTable)
          .doc(productUid)
          .delete();
      print("Success()");
      return(Success());
    }catch(e){
      print(e);
      return Failure(error: e.toString());
    }
  }
}
