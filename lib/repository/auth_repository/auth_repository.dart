import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_market/repository/auth_repository/show_code_input_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../presentation/di/getit_setup.dart';
import '../storage_repository.dart';
import '../constants.dart';
import '../models/user.dart' as models;
import 'on_code_sent.dart';

class AuthRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageRepository _storageRepository = locator<StorageRepository>();

  Future<String> signUpWithPhone(
      {required String phone, required BuildContext context}) async {
    String res = "Some error Occurred";
    try {
      if (phone.isNotEmpty) {
        // registering user in auth with email and password
        print("starting auth $phone");

        await _auth.verifyPhoneNumber(
          phoneNumber: '+79200657986',
          verificationCompleted: (PhoneAuthCredential cred) {},
          verificationFailed: (FirebaseAuthException exception) => {},
          codeSent: (String verificationId, int? forceResendingToken) =>
              onCodeSent(verificationId, forceResendingToken, context, _auth),
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    } catch (err) {
      print('catch an error');
      return err.toString();
    }
    return res;
  }

  Future<String> addUserInfo(models.User user, Uint8List? file) async {
    String res = '';
    try {
      final currentUser = _auth.currentUser;
      if (file != null) {
        user.avatarUrl = await _storageRepository.uploadImageToStorage(
            'profilePics', file, false);
      }

      if (currentUser != null) {
        await _firestore
            .collection(fireStoreUsersTableName)
            .doc(currentUser.uid)
            .set(user.toJson());
      }
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<models.User?> getCurrentUser() async {
    final currentUser = _auth.currentUser;
    if(currentUser != null) {
      final jsonUser = await _firestore
        .collection(fireStoreUsersTableName)
        .doc(currentUser.uid)
        .get();
      return models.User.fromJson(jsonUser.data() as Map<String, dynamic>);
    }
    return null;
  }
}
