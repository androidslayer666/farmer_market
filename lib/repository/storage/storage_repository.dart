import 'dart:typed_data';
import 'package:farmer_market/repository/success_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Result<String, String>> uploadPictureToStorage(String tableName, Uint8List file) async {
    // creating location to our firebase storage

    try {
      Reference ref =
      _storage.ref().child(tableName).child(_auth.currentUser!.uid);
      String id = const Uuid().v1();
      ref = ref.child(id);

      UploadTask uploadTask = ref.putData(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return Success(data: downloadUrl);
    } catch(err) {
      return Failure(error: err.toString());
    }
  }
}
