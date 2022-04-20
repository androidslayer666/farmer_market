import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:farmer_market/presentation/navigation/navigation_wrapper.dart';
import 'package:farmer_market/presentation/screens/main_screen_pages/chat_page/bloc/chat_bloc.dart';
import 'package:farmer_market/presentation/screens/main_screen_pages/chat_page/bloc/chat_event.dart';
import 'package:farmer_market/presentation/screens/main_screen_pages/chat_page/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/getit_setup.dart';
import '../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../data/repository/chat_repository/chat_repository.dart';
import '../../../shared/avatar_name_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final chatRepository = locator<ChatRepository>();
        final authRepository = locator<AuthRepository>();
        return ChatBloc(
            chatRepository: chatRepository, authRepository: authRepository)
          ..add(const ChatEventInit());
      },
      child: const ChatPageBody(),
    );
  }
}

class ChatPageBody extends StatelessWidget {
  const ChatPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      if(state.chats?.isEmpty == true){
        return SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                    'There are no chats yet, please start chatting from a user profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500)),
              ),
            ));
      }
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: state.chats?.length,
              itemBuilder: (context, index) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    navigateToChatScreen(context,
                        arguments: UserDetailArguments(
                            user: state.chats?[index].user));
                  },
                  child: Row(children: [
                    IgnorePointer(
                      child: AvatarNameWidget(
                          user: state.chats?[index].user, onClickNavigate: false),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).primaryColor,
                    )
                  ]))));
    });
  }
}
