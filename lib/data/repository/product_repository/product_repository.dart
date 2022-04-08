import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/api/address.dart';
import '../../models/filter/filter.dart';
import '../../models/product/category.dart';
import '../../models/review/review.dart';
import '../../utils/firestore_query_filtering_builder.dart';
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
          product = product.copyWith(address: address.data, region: address.data?.region);
        }

        if (product.id == null) {
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
      print(e);
      return Failure();
    }
  }

  Future<Result<Product, String>> getProductById(String productId) async {
    try {
      final productQuery = await _firestore
          .collection(fireStoreNameProductTable)
          .doc(productId)
          .get();
      if(productQuery.data() != null) {
        return Success(
          data: Product.fromJson(productQuery.data()!));
      }
      return Failure();
    } catch (e) {
      print(e);
      return Failure();
    }
  }

  Future<Result<List<Product>, String>> getPageOfProducts(
      Filter? filter, String? lastDocument) async {
    final prefs = await SharedPreferences.getInstance();
    final region = prefs.getString('userRegion');
    try {
      Query<Map<String, dynamic>> _query =
          firestoreQueryFilteringBuilder(_firestore, filter, region ?? '');
      if (lastDocument != null) {
        _query = _query.startAfter([lastDocument]);
      }
      _query = _query.limit(5);
      final result = await _query.get();
      return Success(
          data: (result.docs.map((e) => Product.fromJson(e.data())).toList()));
    } catch (e) {
      print('getAllProducts   ' + e.toString());
      return Failure();
    }
  }

  Future<Result<List<Product>, String>> refreshProducts(
      Filter? filter, String? lastDocument) async {
    final prefs = await SharedPreferences.getInstance();
    final region = prefs.getString('userRegion');
    try {
      Query<Map<String, dynamic>> _query =
      firestoreQueryFilteringBuilder(_firestore, filter, region ?? '');
      if (lastDocument != null) {
        _query = _query.endAt([lastDocument]);
      }
      final result = await _query.get();
      return Success(
          data: (result.docs.map((e) => Product.fromJson(e.data())).toList()));
    } catch (e) {
      print('getAllProducts   ' + e.toString());
      return Failure();
    }
  }


  Future<Result<List<Product>, String>> getUserProducts(String userId) async {
    try {
      final listProducts = await _firestore
          .collection(fireStoreNameProductTable)
          .where('userID', isEqualTo: userId)
          .get();
      return Success(
          data: (listProducts.docs
              .map((e) => Product.fromJson(e.data()))
              .toList()));
    } catch (e) {
      print(e);
      return Failure();
    }
  }

  Future<Result> deleteProducts(String productUid) async {
    try {
      await _firestore
          .collection(fireStoreNameProductTable)
          .doc(productUid)
          .delete();
      return (Success());
    } catch (e) {
      print(e);
      return Failure(error: e.toString());
    }
  }

  Future<Result> addReview(Review review, String productId) async {
    try {
      await _firestore
          .collection(fireStoreNameProductTable)
          .doc(productId)
          .update({'reviews' : FieldValue.arrayUnion([review.toJson()])});
      return (Success());
    } catch (e) {
      print(e);
      return Failure(error: e.toString());
    }
  }


}
