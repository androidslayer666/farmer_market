
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../data/models/chat/chat.dart';
import '../../../../../../data/models/user/user.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState(
      {
        List<Chat>? chats,
        @Default({}) Map<Chat, User> mapChatUsers,
        }) = _Initial;
}