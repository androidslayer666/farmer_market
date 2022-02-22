import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:farmer_market/repository/models/api/suggestion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../api/address_suggestions_rest_client.dart';
import '../constants.dart';
import '../models/api/address.dart';
import '../success_failure.dart';
import '../models/user.dart' as models;
import '../models/api/address.dart' as models;

class AddressRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _dio = Dio();

  Future<String?> _getToken() async {
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

  Future<Result<List<Suggestion>, String>> getSuggestions(String query) async {
    final _client = DadataClient(_dio);
    String? _token = await _getToken();

    if (_token != null) {
      final _response = await _client.getSuggestions(query, 'Token $_token');
      return Success(data: _response.suggestions);
    }

    return Failure();
  }

  Future<Result> saveAddress(Address address) async {
    final _currentUser = _auth.currentUser;
    return callWrapper<String>(() async => {
          _currentUser != null
              ? await _firestore
                  .collection(fireStoreNameAddressTable)
                  .doc(_currentUser.uid)
                  .set(address.toJson())
              : {}
        });
    //
    // try {
    // final _currentUser = _auth.currentUser;
    //
    // if (_currentUser != null) {
    // address.userId = _currentUser.uid;
    // await _firestore
    //     .collection(fireStoreNameAddressTable)
    //     .doc(Uuid().v1())
    //     .set(address.toJson());
    // }
    // return Success();
    // } catch (e) {
    // return Failure(error: e.toString());
    // }
  }

  Future<Result<Address, String>> getUserAddress(String userId) async {
    final _currentUser = _auth.currentUser;
    return callWrapper<Address>(() async {
      final response = await _firestore
          .collection(fireStoreUsersTableName)
          .doc(_currentUser?.uid)
          .get();
      //print(response.data());
      return models.User.fromJson(response.data()!).address;
    });

    //final address = Address.fromJson(res.docs.first.data());
    // try {
    //   final result = await _firestore
    //       .collection(fireStoreNameAddressTable)
    //       .where('userId', isEqualTo: userId)
    //       .limit(1)
    //       .get();
    //   final address = Address.fromJson(result.docs.first.data());
    //   return Success(data: address);
    // } catch (e) {
    //   return Failure(error: e.toString());
    // }
  }
}

Future<Result<T, String>> callWrapper<T>(Function() call) async {
  try {
    final result = await call();
    return Success(data: result);
  } catch (e) {
    return Failure(error: e.toString());
  }
}
