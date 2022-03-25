import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:farmer_market/presentation/navigation/navigation_wrapper.dart';
import 'package:farmer_market/presentation/screens/bottom_bar_pages/chat_page/bloc/chat_bloc.dart';
import 'package:farmer_market/presentation/screens/bottom_bar_pages/chat_page/bloc/chat_event.dart';
import 'package:farmer_market/presentation/screens/bottom_bar_pages/chat_page/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/getit_setup.dart';
import '../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../data/repository/chat_repository/chat_repository.dart';

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

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({Key? key}) : super(key: key);

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ...?state.chat?.map((e) => GestureDetector(
                onTap: () {
                  navigateToChatScreen(context,
                      arguments: UserDetailArguments(user: e.user));
                },
                child: Row(children: [
                  CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: e.user?.avatarUrl != null
                          ? NetworkImage(e.user?.avatarUrl ?? '')
                          : null),
                  Text(e.user?.name ?? '')
                ])))
          ],
        ),
      );
    });
  }
}
