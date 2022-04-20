import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_market/data/repository/success_failure.dart';

import 'constants.dart';
import 'firestoreErrorCodeToString.dart';

Future<Result<T, String>> firestoreCaller<T>(Function() call) async {
  try {
    final result = await call();
    // debugPrint('firestoreCaller $result');
    return Success(data: result);
  } catch (e) {
    // debugPrint('firestoreCaller $e');
    if (e is FirebaseException) {
      return Failure(error: firestoreErrorCodeToString(e));
    }
    return Failure(error: defaultErrorString);
  }
}
