import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_market/data/models/cart/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../models/cart/cart.dart';
import '../constants.dart';
import '../interfaces/i_address_repository.dart';
import '../storage/storage_repository.dart';
import '../success_failure.dart';

class CartRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final IAddressRepository _addressRepository;

  CartRepository({required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required IAddressRepository addressRepository})
      : _firestore = firestore,
        _auth = auth,
        _addressRepository = addressRepository;

  Future<Result> saveCart({required Cart cart}) async {
    try {
      final _currentUser = _auth.currentUser;

      if (_currentUser != null) {
        final updatedCart = cart.copyWith(userId: _currentUser.uid);
        final jsonCart = updatedCart.toJson();

        await _firestore
            .collection(fireStoreNameCartTable)
            .doc(_currentUser.uid)
            .set(jsonCart);

        return Success();
      } else {
        print('no user');
        return Failure(error: 'cant recognise the user id, please reboot the app');}

    } catch (e) {
      print(e);
      return Failure(error: e.toString());
    }
  }

  Future<Result<Cart, String>> getCart() async {
    try {
      final _currentUser = _auth.currentUser;
      final jsonCart =
      await _firestore.collection(fireStoreNameCartTable).doc(_currentUser?.uid).get();
      if (jsonCart.data() != null) {
        return Success(
            data: Cart.fromJson(
                jsonCart.data() as Map<String, dynamic>));
      } else {
        return Failure();
      }
    }catch (e) {
      return Failure(error: e.toString());
    }
  }

}