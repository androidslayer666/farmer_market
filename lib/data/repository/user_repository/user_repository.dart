import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user/user.dart' as models;
import '../constants.dart';
import '../firestore_caller.dart';
import '../success_failure.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<Result<models.User, String>> getUserById(String userId) async {
    return firestoreCaller<models.User>(() async {
      final jsonUser = await _firestore
          .collection(fireStoreUsersTableName)
          .doc(userId)
          .get();
      if (jsonUser.data() != null) {
        return models.User.fromJson(jsonUser.data() as Map<String, dynamic>);
      }
    });
  }
}
