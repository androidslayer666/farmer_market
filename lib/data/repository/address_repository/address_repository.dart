import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_market/data/repository/interfaces/i_address_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/api/address_suggestions_rest_client.dart';
import '../constants.dart';
import '../../models/api/address.dart';
import '../../models/api/suggestion.dart';
import '../../models/user/user.dart' as models;
import '../success_failure.dart';
import '../token_provider/token_provider.dart';

class AddressRepository implements IAddressRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final DadataClient _dadataClient;
  final TokenProvider _tokenProvider;

  AddressRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required DadataClient dadataClient,
    required TokenProvider tokenProvider,
  })  : _firestore = firestore,
        _auth = auth,
        _tokenProvider = tokenProvider,
        _dadataClient = dadataClient;

  @override
  Future<Result<List<Suggestion>, String>> getSuggestions(String query) async {
    return callWrapper<List<Suggestion>>(() async {
      String? _token = await _tokenProvider.getDadataToken();
      final _response =
          await _dadataClient.getSuggestions(query, 'Token $_token');
      return _response.suggestions;
    });
  }

  @override
  Future<Result> saveAddress(Address address) async {
    final _currentUser = _auth.currentUser;
    return callWrapper<String>(() async => {
          if (_currentUser != null)
            {
              await _firestore
                  .collection(fireStoreNameAddressTable)
                  .doc(_currentUser.uid)
                  .set(address.toJson())
            }
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

  @override
  Future<Result<Address, String>> getUserAddress(String userId) async {
    final _currentUser = _auth.currentUser;
    return callWrapper<Address>(() async {
      final response = await _firestore
          .collection(fireStoreUsersTableName)
          .doc(_currentUser?.uid)
          .get();
      return models.User.fromJson(response.data()!).address;
    });

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
