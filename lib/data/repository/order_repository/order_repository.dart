import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/order/order.dart';
import '../constants.dart';
import '../interfaces/i_address_repository.dart';
import '../success_failure.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final IAddressRepository _addressRepository;

  OrderRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required IAddressRepository addressRepository})
      : _firestore = firestore,
        _auth = auth,
        _addressRepository = addressRepository;

  Future<Result> saveOrder({required Order order}) async {
    try {
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

        return Success();
      } else {
        print('no user');
        return Failure(
            error: 'cant recognise the user id, please reboot the app');
      }
    } catch (e) {
      print(e);
      return Failure(error: e.toString());
    }
  }

  Future<Result<List<Order>, String>> getOrders() async {
    try {
      final _currentUser = _auth.currentUser;
      final jsonOrder = await _firestore
          .collection(fireStoreNameOrderTable)
          .doc(_currentUser?.uid)
          .collection(fireStoreNameOrderSubTable)
          .where('purchaserId', isEqualTo: _currentUser?.uid)
          .get();

      final List<Order> listOrders =
          jsonOrder.docs.map((e) => Order.fromJson(e.data())).toList();
      return Success(data: listOrders);
    } catch (e) {
      print(e);
      return Failure(error: e.toString());
    }
  }
}
