import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../app/bloc/app_state.dart';
import '../../../app/di/getit_setup.dart';
import '../../../data/models/chat/message.dart';
import '../../../data/repository/chat_repository/chat_repository.dart';
import '../../navigation/arguments.dart';
import '../../shared/app_bar.dart';
import 'chat_screen_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatScreenCubit? _chatScreenCubit;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as UserDetailArguments?;
    final _chatRepository = locator<ChatRepository>();

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) => BlocProvider<ChatScreenCubit>(
        create: (context) {
          _chatScreenCubit = ChatScreenCubit(_chatRepository)
            ..onInit(args?.user);
          return _chatScreenCubit!;
        },
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

  @override
  void dispose() {
    _chatScreenCubit?.close();
    super.dispose();
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ChatScreenAvatar(state: state),
            ChatScreenMessageList(
                userId: userId, listMessages: state.chat.listMessages),
            ChatScreenTextInput(chatScreenCubit: chatScreenCubit)
          ],
        ),
      ),
    );
  }
}

class ChatScreenTextInput extends StatefulWidget {
  const ChatScreenTextInput({Key? key, required this.chatScreenCubit})
      : super(key: key);

  final ChatScreenCubit chatScreenCubit;

  @override
  State<ChatScreenTextInput> createState() => _ChatScreenTextInputState();
}

class _ChatScreenTextInputState extends State<ChatScreenTextInput> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey.shade200,
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              controller: _messageController,
            ),
          )),
          IconButton(
              onPressed: () {
                widget.chatScreenCubit.sendMessage(_messageController.text);
                _messageController.text = '';
              },
              icon: Icon(Icons.send, color: Theme.of(context).primaryColor,))
        ],
      ),
    );
  }
}

class ChatScreenAvatar extends StatelessWidget {
  const ChatScreenAvatar({Key? key, required this.state}) : super(key: key);

  final ChatScreenState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey.withOpacity(0.2),
      child: Row(
        children: [
          CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: state.user?.avatarUrl != null
                  ? NetworkImage(state.user?.avatarUrl ?? '')
                  : null),
          const SizedBox(
            width: 16,
          ),
          Text(state.user?.name ?? ''),
        ],
      ),
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.listMessages?.length ?? 0,
          itemBuilder: (context, index) => MessageItemWidget(
            message: widget.listMessages![index],
            userId: widget.userId,
          ),
        ),
      ),
    );
  }
}

class MessageItemWidget extends StatefulWidget {
  const MessageItemWidget({
    Key? key,
    required this.message,
    required this.userId,
  }) : super(key: key);

  final Message message;
  final String userId;

  @override
  State<MessageItemWidget> createState() => _MessageItemWidgetState();
}

class _MessageItemWidgetState extends State<MessageItemWidget> {
  bool showDelete = false;

  @override
  Widget build(BuildContext context) {
    final chatScreenCubit = context.read<ChatScreenCubit>();
    return Align(
      alignment: widget.message.usedId == widget.userId
          ? Alignment.topRight
          : Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          setState(() {
            showDelete = !showDelete;
          });
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: widget.message.usedId != widget.userId
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.message.time != null)
                        Text(DateFormat('jm').format(widget.message.time!),
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade400)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          widget.message.message ?? '',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.bodyText2,
                          maxLines: 15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (showDelete)
                    GestureDetector(
                        onTap: () {
                          showDelete = false;
                          chatScreenCubit
                              .deleteMessage(widget.message.id ?? '');
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.delete,
                            size: 20,
                          ),
                        ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
