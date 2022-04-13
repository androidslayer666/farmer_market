import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/data/models/chat/message.dart';
import 'package:farmer_market/data/repository/chat_repository/chat_repository.dart';
import 'package:farmer_market/data/repository/success_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/chat/chat.dart';
import '../../../data/models/user/user.dart';

part 'chat_screen_cubit.freezed.dart';

@freezed
class ChatScreenState with _$ChatScreenState {
  const factory ChatScreenState(
      {User? user,
      @Default(Chat()) Chat chat,
      @Default('') String messageString,
      String? errorString}) = _Initial;
}

class ChatScreenCubit extends Cubit<ChatScreenState> {
  ChatScreenCubit(ChatRepository chatRepository)
      : _chatRepository = chatRepository,
        super(const ChatScreenState());

  final ChatRepository _chatRepository;

  late final StreamSubscription chatSubscription;

  void onInit(User? user) async {
    final stream = _chatRepository.getChatBuIdStream(user?.id ?? '');
    emit(state.copyWith(user: user));
    chatSubscription = stream.listen((event) {
      if (event is Success<Chat, String>) {
        if (event.data != null) {
          emit(state.copyWith(chat: event.data!, errorString: null));
        }
      } else if (event is Failure<Chat, String>) {
        emit(state.copyWith(errorString: event.error));
      }
    });
  }

  void onChangeTextInput(String text) {
    emit(state.copyWith(messageString: text));
  }

  void sendMessage(String message) {
    final messageId = const Uuid().v1();
    final listMessages = [
      ...?state.chat.listMessages,
      Message(
          message: message,
          usedId: state.user?.id,
          id: messageId,
          time: DateTime.now())
    ];
    Chat? chat = state.chat.copyWith(listMessages: listMessages);
    if (state.chat.user == null && state.user?.id != null) {
      chat = chat.copyWith(user: state.user);
    }
    if (message.isNotEmpty) {
      _chatRepository.saveChat(chat);
    }
  }

  void deleteMessage(String messageID) {
    final listMessages = [...?state.chat.listMessages];
    listMessages.removeAt(
        listMessages.indexWhere((element) => element.id == messageID));
    _chatRepository
        .saveChat(state.chat.copyWith(listMessages: listMessages));
  }

  @override
  Future<void> close() async {
    await chatSubscription.cancel();
    return super.close();
  }
}
