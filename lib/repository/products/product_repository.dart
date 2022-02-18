import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../app/di/getit_setup.dart';
import '../constants.dart';
import '../models/product.dart';
import '../storage/storage_repository.dart';
import '../success_failure.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageRepository _storageRepository = locator<StorageRepository>();

  Future<Result> saveProduct(Product product, Uint8List? file) async {
    try {
      final currentUser = _auth.currentUser;
      if (file != null) {
        final result = await _storageRepository.uploadPictureToStorage(
            fireStoreNameProductPics, file);
        if (result is Success<String>) {
          product.pictureUrl = result.data;
        }
      }
      if (currentUser != null) {
        await _firestore
            .collection(fireStoreNameProductTable)
            .doc(Uuid().v1())
            .set(product.toJson());
      }
      return Success(data: null);
    } catch (e) {
      return Failure(data: null);
    }
  }

  Future<Result<List<Product>>> getAllProducts() async {
    try {
      final listProducts =
          await _firestore.collection(fireStoreNameProductTable).get();
      print("sdfvlknsdfv     " + listProducts.docs.first.data().toString());
      return Success(data: (listProducts.docs.map((e) => Product.fromJson(e.data() as Map<String, dynamic>)).toList()));
    } catch (e) {
      return Failure(data: null);
    }
  }
}
