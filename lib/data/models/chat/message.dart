import 'package:freezed_annotation/freezed_annotation.dart';

import '../user/user.dart';


part 'message.freezed.dart';

part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message(
      {String? id,
        String? usedId,
        String? message,
        DateTime? time
      }) = _Initial;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}