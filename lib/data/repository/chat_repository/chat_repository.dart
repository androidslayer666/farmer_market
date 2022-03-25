import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_market/data/models/chat/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../models/chat/chat.dart';
import '../constants.dart';
import '../interfaces/i_address_repository.dart';
import '../storage/storage_repository.dart';
import '../success_failure.dart';

class ChatRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ChatRepository(
      {required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;

  Future<Result> saveChat(Chat chat) async {
    try {
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

      return Success();
    } catch (e) {
      print(e);
      return Failure();
    }
  }

  Future<Result<List<Chat>, String>> getUserChats() async {
    final _currentUser = _auth.currentUser;
    try {
      final result = await _firestore
          .collection(fireStoreNameChatTable)
          .doc(_currentUser?.uid)
          .collection(fireStoreNameChatSubTable)
          .get();

      final listChats =
          result.docs.map((e) => Chat.fromJson(e.data())).toList();
      print(listChats);
      return Success(data: listChats);
    } catch (e) {
      print(e);
      return Failure();
    }
  }

  Future<Result<Chat, String>> getChatBuId(String userId) async {
    final _currentUser = _auth.currentUser;
    try {
      final result = await _firestore
          .collection(fireStoreNameChatTable)
          .doc(_currentUser?.uid)
          .collection(fireStoreNameChatSubTable)
          .doc(userId)
          .get();

      if(result.data() != null) {
        final chat =
        Chat.fromJson(result.data()!);
        return Success(data: chat);
      }
      return Failure();
    } catch (e) {
      print(e);
      return Failure();
    }
  }

  Stream<Chat> getChatBuIdStream(String userId) async* {
    print('getChatBuIdStream');
    final _currentUser = _auth.currentUser;
    try {
      final result = await _firestore
          .collection(fireStoreNameChatTable)
          .doc(_currentUser?.uid)
          .collection(fireStoreNameChatSubTable)
          .doc(userId)
          .snapshots();

      await for (final chatReceived in result){
        print(chatReceived.data());
        yield Chat.fromJson(chatReceived.data()!);
      }

    } catch (e) {
      print(e);
    }
  }
}
