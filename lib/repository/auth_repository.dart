import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../presentation/di/getit_setup.dart';
import 'storage_repository.dart';
import 'constants.dart';
import 'models/user.dart' as models;

class AuthRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageRepository _storageRepository = locator<StorageRepository>();

  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required bool isSeller,
    Uint8List? file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Adding avatar to the storage

        String? photoUrl;
        if (file != null) {
          photoUrl = await _storageRepository.uploadImageToStorage(
              'profilePics', file, false);
        }

        models.User _user = models.User(
            name: name,
            email: email,
            isSeller: isSeller,
            password: password,
            avatarUrl: photoUrl);

        //adding user in our database
        await _firestore
            .collection(fireStoreUsersTableName)
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}
