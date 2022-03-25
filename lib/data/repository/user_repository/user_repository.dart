import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';
import '../storage/storage_repository.dart';
import '../success_failure.dart';
import '../../models/user/user.dart' as models;

class UserRepository {
  final FirebaseFirestore _firestore;


  UserRepository(
      {required FirebaseFirestore firestore })
      : _firestore = firestore;

  Future<Result<models.User, String>> getUserById(String userId) async {
    try {
      final jsonUser =
      await _firestore.collection(fireStoreUsersTableName).doc(userId).get();
      if (jsonUser.data() != null) {
        return Success(
            data: models.User.fromJson(
                jsonUser.data() as Map<String, dynamic>));
      } else {
        return Failure();
      }
    }catch (e) {
      return Failure(error: e.toString());
    }
  }
}
