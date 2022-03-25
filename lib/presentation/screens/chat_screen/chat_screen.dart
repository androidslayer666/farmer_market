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
        create: (context) => ChatScreenCubit(_chatRepository),
        child: Scaffold(
          appBar: CustomAppBar(user: appState.currentUser),
          body: ChatScreenBody(
              args: args, userId: appState.currentUser?.id ?? ''),
        ),
      ),
    );
  }
}

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({Key? key, this.args, required this.userId})
      : super(key: key);

  final UserDetailArguments? args;
  final String userId;

  @override
  State<ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final chatScreenCubit = context.read<ChatScreenCubit>();
    if (widget.args?.user != null) chatScreenCubit.onInit(widget.args!.user!);
  }

  @override
  Widget build(BuildContext context) {
    final chatScreenCubit = context.read<ChatScreenCubit>();

    return BlocBuilder<ChatScreenCubit, ChatScreenState>(
        builder: (context, state) {
      return Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: state.user?.avatarUrl != null
                      ? NetworkImage(state.user?.avatarUrl ?? '')
                      : null),
              Text(state.user?.name ?? ''),
            ],
          ),
          MessageList(
              userId: widget.userId, listMessages: state.chat.listMessages),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: textController,
              )),
              IconButton(
                  onPressed: () {
                    chatScreenCubit.sendMessage(
                        state.user, textController.text);
                  },
                  icon: const Icon(Icons.send))
            ],
          )
        ],
      );
    });
  }
}

class MessageList extends StatefulWidget {
  const MessageList(
      {Key? key, required this.listMessages, required this.userId})
      : super(key: key);

  final List<Message>? listMessages;
  final String userId;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Message? clickedMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
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
