import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../models/chat/chat.dart';
import '../constants.dart';
import '../firestoreErrorCodeToString.dart';
import '../firestore_caller.dart';
import '../success_failure.dart';

class ChatRepository {
  ChatRepository(
      {required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<Result> saveChat(Chat chat) async {
    return firestoreCaller(() async {
      final _currentUser = _auth.currentUser;

      if (_currentUser != null) {
        if (chat.id == null) {
          chat = chat.copyWith(id: const Uuid().v1());
        }

        final jsonChat = chat.toJson();

        if (chat.user?.id != null) {
          await _firestore
              .collection(fireStoreNameChatTable)
              .doc(_currentUser.uid)
              .collection(fireStoreNameChatSubTable)
              .doc(chat.user?.id)
              .set(jsonChat);
        }
      }
    });
  }

  Future<Result<List<Chat>, String>> getUserChats() async {
    return firestoreCaller<List<Chat>>(() async {
      final _currentUser = _auth.currentUser;

      if (_currentUser != null) {
        final result = await _firestore
            .collection(fireStoreNameChatTable)
            .doc(_currentUser.uid)
            .collection(fireStoreNameChatSubTable)
            .get();

        final listChats =
            result.docs.map((e) => Chat.fromJson(e.data())).toList();
        return listChats;
      }
    });
  }

  Future<Result<Chat, String>> getChatBuId(String userId) async {
    return firestoreCaller<Chat>(() async {
      final _currentUser = _auth.currentUser;

      if (_currentUser != null) {
        final result = await _firestore
            .collection(fireStoreNameChatTable)
            .doc(_currentUser.uid)
            .collection(fireStoreNameChatSubTable)
            .doc(userId)
            .get();

        if (result.data() != null) {
          return Chat.fromJson(result.data()!);
        }
      }
    });
  }

  Stream<Result<Chat, String>> getChatBuIdStream(String userId) async* {
    final _currentUser = _auth.currentUser;
    try {
      final result = _firestore
          .collection(fireStoreNameChatTable)
          .doc(_currentUser?.uid)
          .collection(fireStoreNameChatSubTable)
          .doc(userId)
          .snapshots();

      await for (final chatReceived in result) {
        yield Success(data: Chat.fromJson(chatReceived.data()!));
      }
    } catch (e) {
      if (e is FirebaseException) {
        yield (Failure(error: firestoreErrorCodeToString(e)));
      } else {
        yield (Failure(error: e.toString()));
      }
    }
  }
}
