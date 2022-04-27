import 'package:bloc/bloc.dart';
import 'package:farmer_market/data/repository/auth_repository/auth_repository.dart';
import 'package:farmer_market/data/repository/chat_repository/chat_repository.dart';
import 'package:farmer_market/data/repository/user_repository/user_repository.dart';

import '../../../../../../data/models/chat/chat.dart';
import '../../../../../../data/models/user/user.dart';
import '../../../../../../data/repository/success_failure.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required ChatRepository chatRepository,
    required AuthRepository authRepository, required UserRepository userRepository})
      : _chatRepository = chatRepository,
        _userRepository = userRepository,
        _authRepository = authRepository,
        super(const ChatState()) {
    on<ChatEventInit>(_onInit);
  }

  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  void _onInit(
      ChatEventInit event,
      Emitter<ChatState> emit
      ) async {
    final result = await _chatRepository.getUserChats();
    final currentUserId = _authRepository.getUserId();
    final Map<Chat,User> map = {};
    if (result is Success<List<Chat>,String>){
      if(result.data != null) {
        for (final chat in result.data!) {
          final String? anotherUserId;
          if(chat.userIds?.first == currentUserId){
            anotherUserId = chat.userIds?[1];
          } else {
            anotherUserId = chat.userIds?.first;
          }
          if(anotherUserId != null) {
            final result = await _userRepository.getUserById(anotherUserId);
            if(result is Success<User, String> ) {
              if (result.data != null) {
                map[chat] = result.data!;
              }
            }
          }
        }
      }
      emit(state.copyWith(mapChatUsers: map, chats: result.data));
    }
  }
}