import 'package:freezed_annotation/freezed_annotation.dart';

import '../convertors.dart';
import '../user/user.dart';
import 'message.dart';


part 'chat.freezed.dart';

part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat(
      {String? id,
        @JsonKey(toJson: userToJson)
        User? user,
        @JsonKey(toJson: listMessagesToJson)
        List<Message>? listMessages
      }) = _Initial;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}