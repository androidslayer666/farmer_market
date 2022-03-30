import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../app/bloc/app_state.dart';
import '../../../app/di/getit_setup.dart';
import '../../../data/models/chat/message.dart';
import '../../../data/repository/chat_repository/chat_repository.dart';
import '../../navigation/arguments.dart';
import '../../shared/app_bar.dart';
import 'chat_screen_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as UserDetailArguments?;
    final _chatRepository = locator<ChatRepository>();

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) => BlocProvider<ChatScreenCubit>(
        create: (context) =>
            ChatScreenCubit(_chatRepository)..onInit(args?.user),
        child: BlocBuilder<ChatScreenCubit, ChatScreenState>(
            builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(user: appState.currentUser),
            body: ChatScreenBody(
                state: state,
                args: args,
                userId: appState.currentUser?.id ?? ''),
          );
        }),
      ),
    );
  }
}

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody(
      {Key? key, this.args, required this.userId, required this.state})
      : super(key: key);

  final UserDetailArguments? args;
  final String userId;
  final ChatScreenState state;

  @override
  Widget build(BuildContext context) {
    final chatScreenCubit = context.read<ChatScreenCubit>();
    return SafeArea(
      child: Column(
        children: [
          ChatScreenAvatarBloc(state: state),
          ChatScreenMessageList(
              userId: userId, listMessages: state.chat.listMessages),
          ChatScreenTextInput(chatScreenCubit: chatScreenCubit)
        ],
      ),
    );
  }
}

class ChatScreenTextInput extends StatelessWidget {
  const ChatScreenTextInput({Key? key, required this.chatScreenCubit}) : super(key: key);

  final ChatScreenCubit chatScreenCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
              onChanged: (value) => chatScreenCubit.onChangeTextInput(value),
            )),
        IconButton(
            onPressed: () {
              chatScreenCubit.sendMessage();
            },
            icon: const Icon(Icons.send))
      ],
    );
  }
}


class ChatScreenAvatarBloc extends StatelessWidget {
  const ChatScreenAvatarBloc({Key? key, required this.state }) : super(key: key);

  final ChatScreenState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: state.user?.avatarUrl != null
                ? NetworkImage(state.user?.avatarUrl ?? '')
                : null),
        Text(state.user?.name ?? ''),
      ],
    );
  }
}


class ChatScreenMessageList extends StatefulWidget {
  const ChatScreenMessageList(
      {Key? key, required this.listMessages, required this.userId})
      : super(key: key);

  final List<Message>? listMessages;
  final String userId;

  @override
  State<ChatScreenMessageList> createState() => _ChatScreenMessageListState();
}

class _ChatScreenMessageListState extends State<ChatScreenMessageList> {
  Message? clickedMessage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...?widget.listMessages?.map((e) => GestureDetector(
                  onTap: () {
                    e.id == clickedMessage?.id
                        ? setState(() {
                            clickedMessage = null;
                          })
                        : setState(() {
                            clickedMessage = e;
                          });
                  },
                  child: MessageItemWidget(
                    message: e,
                    userId: widget.userId,
                    clickedMessage: clickedMessage,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget(
      {Key? key,
      required this.message,
      required this.userId,
      required this.clickedMessage})
      : super(key: key);

  final Message message;
  final String userId;
  final Message? clickedMessage;

  @override
  Widget build(BuildContext context) {
    final chatScreenCubit = context.read<ChatScreenCubit>();
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: message.usedId != userId
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Text(message.message ?? ''),
          if (message.id == clickedMessage?.id)
            IconButton(
                onPressed: () {
                  chatScreenCubit.deleteMessage(message.id ?? '');
                },
                icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
