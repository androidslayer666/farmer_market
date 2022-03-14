import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../presentation/screens/phone_enter_screen/bloc/phone_enter_bloc.dart';
import '../constants.dart';
import '../../models/user/user.dart' as models;
import '../storage/storage_repository.dart';
import '../success_failure.dart';
import 'on_code_sent.dart';

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final StorageRepository _storageRepository;

  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required StorageRepository storageRepository})
      : _firestore = firestore,
        _auth = auth,
        _storageRepository = storageRepository;

  Future<Result> signUpWithPhone(
      {required String phone, required PhoneEnterBloc bloc}) async {
    try {
      if (phone.isNotEmpty) {
        await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential cred) {},
          verificationFailed: (FirebaseAuthException exception) => {},
          codeSent: (String verificationId, int? forceResendingToken) =>
              onCodeSent(verificationId, forceResendingToken, bloc, _auth),
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
      return Success(data: null);
    } catch (err) {
      return Failure(error: err.toString());
    }
  }

  Future<Result> addUserInfo(models.User user, Uint8List? file) async {
    try {
      final currentUser = _auth.currentUser;
      if (file != null) {
        final result = await _storageRepository.uploadPictureToStorage(
            fireStoreNameProfilePics, file);
        if (result is Success<String, String>) {
          user = user.copyWith(avatarUrl: (result as Success<String, String>).data);
        }
      }
      final jsonUser = user.toJson();

      if (currentUser != null) {
        await _firestore
            .collection(fireStoreUsersTableName)
            .doc(currentUser.uid)
            .set(jsonUser);
      }
      return Success(data: null);
    } catch (err) {
      return Failure(error: err.toString());
    }
  }

  Future<Result<models.User, String>> getCurrentUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final jsonUser = await _firestore
          .collection(fireStoreUsersTableName)
          .doc(currentUser.uid)
          .get();
      if (jsonUser.data() != null) {
        return Success(
            data:
                models.User.fromJson(jsonUser.data() as Map<String, dynamic>));
      } else {
        return Failure(error: null);
      }
    } else {
      return Failure(error: null);
    }
  }

  Future<String?> getUserId() async {
    return _auth.currentUser?.uid;
  }

  Future<Result> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return Success(data: null);
    } catch (e) {
      return Failure(error: null);
    }
  }
}
