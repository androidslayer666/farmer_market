import 'package:bloc/bloc.dart';
import 'package:farmer_market/data/models/chat/message.dart';
import 'package:farmer_market/data/repository/chat_repository/chat_repository.dart';
import 'package:farmer_market/data/repository/product_repository/product_repository.dart';
import 'package:farmer_market/data/repository/user_repository/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/chat/chat.dart';
import '../../../data/models/product/product.dart';
import '../../../data/models/user/user.dart';
import '../../../data/repository/success_failure.dart';

part 'chat_screen_cubit.freezed.dart';

@freezed
class ChatScreenState with _$ChatScreenState {
  const factory ChatScreenState({User? user, @Default(Chat()) Chat chat}) =
      _Initial;
}

class ChatScreenCubit extends Cubit<ChatScreenState> {
  ChatScreenCubit(ChatRepository chatRepository)
      : _chatRepository = chatRepository,
        super(const ChatScreenState());

  final ChatRepository _chatRepository;

  void onInit(User user) async {
    final stream = _chatRepository.getChatBuIdStream(user.id ?? '');
    emit(state.copyWith(user: user));
    stream.listen((event) {
      emit(state.copyWith(chat: event));
    });
  }

  void sendMessage(User? user, String message) {
    final messageId = const Uuid().v1();
    final listMessages = [
      ...?state.chat.listMessages,
      Message(message: message, usedId: user?.id, id: messageId)
    ];
    Chat? chat = state.chat.copyWith(listMessages: listMessages);
    if (state.chat.user == null && user?.id != null) {
      chat = chat.copyWith(user: user);
    }
    final result = _chatRepository.saveChat(chat);
    //print(result is Success);
  }

  void deleteMessage(String messageID) {
    final listMessages = [...?state.chat.listMessages];
    listMessages.removeAt(
        listMessages.indexWhere((element) => element.id == messageID));
    final result = _chatRepository
        .saveChat(state.chat.copyWith(listMessages: listMessages));
  }
}
