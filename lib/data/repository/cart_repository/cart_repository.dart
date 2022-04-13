import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/cart/cart.dart';
import '../constants.dart';
import '../firestore_caller.dart';
import '../success_failure.dart';

class CartRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CartRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;

  Future<Result> saveCart({required Cart cart}) async {
    return firestoreCaller(() async {
      final _currentUser = _auth.currentUser;

      if (_currentUser != null) {
        final updatedCart = cart.copyWith(userId: _currentUser.uid);
        final jsonCart = updatedCart.toJson();

        await _firestore
            .collection(fireStoreNameCartTable)
            .doc(_currentUser.uid)
            .set(jsonCart);
      }
    });
  }

  Future<Result<Cart, String>> getCart() async {
    return firestoreCaller<Cart>(() async {
      final _currentUser = _auth.currentUser;
      final jsonCart = await _firestore
          .collection(fireStoreNameCartTable)
          .doc(_currentUser?.uid)
          .get();
      if (jsonCart.data() != null) {
        return Cart.fromJson(jsonCart.data() as Map<String, dynamic>);
      }
    });
  }
}
