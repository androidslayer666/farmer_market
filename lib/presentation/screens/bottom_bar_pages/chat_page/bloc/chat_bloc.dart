import 'package:bloc/bloc.dart';
import 'package:farmer_market/data/repository/auth_repository/auth_repository.dart';
import 'package:farmer_market/data/repository/chat_repository/chat_repository.dart';

import '../../../../../data/models/chat/chat.dart';
import '../../../../../data/repository/success_failure.dart';
import '../../chat_page/bloc/chat_event.dart';
import '../../chat_page/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required ChatRepository chatRepository,
    required AuthRepository authRepository})
      : _chatRepository = chatRepository,
        _authRepository = authRepository,
        super(const ChatState()) {
    on<ChatEventInit>(_onInit);
  }

  final AuthRepository _authRepository;

  final ChatRepository _chatRepository;


  void _onInit(
      ChatEventInit event,
      Emitter<ChatState> emit
      ) async {
    final result = await _chatRepository.getUserChats();
    if (result is Success<List<Chat>,String>){
      emit(state.copyWith(chat: result.data));
    }
  }
}