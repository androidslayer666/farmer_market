import 'package:freezed_annotation/freezed_annotation.dart';

import '../convertors.dart';
import 'message.dart';


part 'chat.freezed.dart';

part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat(
      {String? id,
        List<String>? userIds,
        @JsonKey(toJson: listMessagesToJson)
        List<Message>? listMessages
      }) = _Initial;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}