import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../app/di/getit_setup.dart';
import '../../presentation/screens/phone_enter_screen/bloc/phone_enter_bloc.dart';
import '../../presentation/shared/constants.dart';
import '../constants.dart';
import '../models/user.dart' as models;
import '../storage/storage_repository.dart';
import '../success_failure.dart';
import 'on_code_sent.dart';

class AuthRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageRepository _storageRepository = locator<StorageRepository>();

  Future<Result> signUpWithPhone(
      {required String phone, required PhoneEnterBloc bloc}) async {
    try {
      if (phone.isNotEmpty) {
        // registering user in auth with email and password
        print("starting auth $phone");

        await _auth.verifyPhoneNumber(
          phoneNumber: '+79200657986',
          verificationCompleted: (PhoneAuthCredential cred) {},
          verificationFailed: (FirebaseAuthException exception) => {},
          codeSent: (String verificationId, int? forceResendingToken) =>
              onCodeSent(verificationId, forceResendingToken, bloc, _auth),
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
      return Success(data: null);
    } catch (err) {
      print(err.toString());
      return Failure(data: err.toString());
    }
  }

  Future<Result> addUserInfo(models.User user, Uint8List? file) async {
    try {
      final currentUser = _auth.currentUser;
      if (file != null) {
        final result =
        await _storageRepository.uploadPictureToStorage(fireStoreNameProfilePics, file);
        if (result is Success<String>) {
          user.avatarUrl = result.data;
        }
      }
      if (currentUser != null) {
        await _firestore
            .collection(fireStoreUsersTableName)
            .doc(currentUser.uid)
            .set(user.toJson());
      }
      return Success(data: null);
    } catch (err) {
      return Failure(data: err.toString());
    }
  }

  Future<Result<models.User>> getCurrentUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final jsonUser = await _firestore
          .collection(fireStoreUsersTableName)
          .doc(currentUser.uid)
          .get();
      if(jsonUser.data() != null) {

        return Success(
          data: models.User.fromJson(jsonUser.data() as Map<String, dynamic>));
      } else {

        return Failure(data: null);
      }
    }else {
      return Failure(data: null);
    }
  }

  Future<Result> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return Success(data: null);
    }
    catch (e) {
      return Failure(data: null);
    }
  }
}
