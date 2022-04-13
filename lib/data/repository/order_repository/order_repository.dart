import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/order/order.dart';
import '../constants.dart';
import '../firestore_caller.dart';
import '../success_failure.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;

  Future<Result> saveOrder({required Order order}) async {
    return firestoreCaller(() async {
      final _currentUser = _auth.currentUser;

      if (_currentUser != null) {
        final _currentUser = _auth.currentUser;

        if (_currentUser != null) {
          if (order.purchaserId == null) {
            order = order.copyWith(purchaserId: _currentUser.uid);
          }
          final jsonCart = order.toJson();

          await _firestore
              .collection(fireStoreNameOrderTable)
              .doc(order.shipperId)
              .collection(fireStoreNameOrderSubTable)
              .doc(order.id)
              .set(jsonCart);
        }
      }
    });
  }

  Future<Result<List<Order>, String>> getOrders() async {
    return firestoreCaller<List<Order>>(() async {
      final _currentUser = _auth.currentUser;
      final jsonOrder = await _firestore
          .collection(fireStoreNameOrderTable)
          .doc(_currentUser?.uid)
          .collection(fireStoreNameOrderSubTable)
          .where('purchaserId', isEqualTo: _currentUser?.uid)
          .get();

      final List<Order> listOrders =
      jsonOrder.docs.map((e) => Order.fromJson(e.data())).toList();
      return listOrders;
    });
  }
}
