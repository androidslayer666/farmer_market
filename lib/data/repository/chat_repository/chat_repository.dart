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

        chat = chat.copyWith(userIds: [...?chat.userIds, _currentUser.uid]);

        final jsonChat = chat.toJson();

        await _firestore
            .collection(fireStoreNameChatTable)
            .doc(chat.id)
            .set(jsonChat);

        return Success;
      }
    });
  }

  Future<Result<List<Chat>, String>> getUserChats() async {
    return firestoreCaller<List<Chat>>(() async {
      final _currentUser = _auth.currentUser;

      if (_currentUser != null) {
        final result = await _firestore
            .collection(fireStoreNameChatTable)
            .where('userIds', arrayContains: _auth.currentUser!.uid)
            .get();

        final listChats =
            result.docs.map((e) => Chat.fromJson(e.data())).toList();
        return listChats;
      }
    });
  }

  Stream<Result<Chat, String>> getChatBuIdStream(String userId) async* {
    try {
      final result = await _firestore
          .collection(fireStoreNameChatTable)
          .where('userIds', arrayContains: _auth.currentUser!.uid)
          .get();
      if (result.size != 0) {
        for (final chat in result.docs) {
          if (Chat.fromJson(chat.data()).userIds?.contains(userId) == true &&
              Chat.fromJson(chat.data())
                      .userIds
                      ?.contains(_auth.currentUser!.uid) ==
                  true) {
            final resultStream = _firestore
                .collection(fireStoreNameChatTable)
                .doc(Chat.fromJson(chat.data()).id)
                .snapshots();

            await for (final chatReceived in resultStream) {
              if (chatReceived.data() != null) {
                yield Success(data: Chat.fromJson(chatReceived.data()!));
              }
            }
          }
        }
      } else {
        //create new chat
        await saveChat(Chat(userIds: [userId]));

        final result = _firestore
            .collection(fireStoreNameChatTable)
            .where('userIds', arrayContains: _auth.currentUser!.uid)
            .snapshots();

        await for (final chatReceived in result) {
          yield Success(data: Chat.fromJson(chatReceived.docs.first.data()));
        }
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
