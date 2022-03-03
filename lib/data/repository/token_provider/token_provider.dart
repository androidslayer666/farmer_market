


import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class TokenProvider {
  final FirebaseFirestore _firestore;

  TokenProvider({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Future<String?> getDadataToken() async {
    String? _token;
    final tokenResult = await _firestore
        .collection(fireStoreNameKeysTable)
        .doc(fireStoreNameKeyDocument)
        .get();

    if (tokenResult.data() != null) {
      _token = (tokenResult.data()
      as Map<String, dynamic>)[fireStoreNameKeyDadataParameter];
    }
    return _token;
  }

}