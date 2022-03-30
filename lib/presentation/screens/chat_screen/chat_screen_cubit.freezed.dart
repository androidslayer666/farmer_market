// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_screen_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChatScreenStateTearOff {
  const _$ChatScreenStateTearOff();

  _Initial call(
      {User? user, Chat chat = const Chat(), String messageString = ''}) {
    return _Initial(
      user: user,
      chat: chat,
      messageString: messageString,
    );
  }
}

/// @nodoc
const $ChatScreenState = _$ChatScreenStateTearOff();

/// @nodoc
mixin _$ChatScreenState {
  User? get user => throw _privateConstructorUsedError;
  Chat get chat => throw _privateConstructorUsedError;
  String get messageString => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatScreenStateCopyWith<ChatScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatScreenStateCopyWith<$Res> {
  factory $ChatScreenStateCopyWith(
          ChatScreenState value, $Res Function(ChatScreenState) then) =
      _$ChatScreenStateCopyWithImpl<$Res>;
  $Res call({User? user, Chat chat, String messageString});

  $UserCopyWith<$Res>? get user;
  $ChatCopyWith<$Res> get chat;
}

/// @nodoc
class _$ChatScreenStateCopyWithImpl<$Res>
    implements $ChatScreenStateCopyWith<$Res> {
  _$ChatScreenStateCopyWithImpl(this._value, this._then);

  final ChatScreenState _value;
  // ignore: unused_field
  final $Res Function(ChatScreenState) _then;

  @override
  $Res call({
    Object? user = freezed,
    Object? chat = freezed,
    Object? messageString = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      chat: chat == freezed
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as Chat,
      messageString: messageString == freezed
          ? _value.messageString
          : messageString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }

  @override
  $ChatCopyWith<$Res> get chat {
    return $ChatCopyWith<$Res>(_value.chat, (value) {
      return _then(_value.copyWith(chat: value));
    });
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $ChatScreenStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({User? user, Chat chat, String messageString});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $ChatCopyWith<$Res> get chat;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$ChatScreenStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? user = freezed,
    Object? chat = freezed,
    Object? messageString = freezed,
  }) {
    return _then(_Initial(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      chat: chat == freezed
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as Chat,
      messageString: messageString == freezed
          ? _value.messageString
          : messageString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {this.user, this.chat = const Chat(), this.messageString = ''});

  @override
  final User? user;
  @JsonKey()
  @override
  final Chat chat;
  @JsonKey()
  @override
  final String messageString;

  @override
  String toString() {
    return 'ChatScreenState(user: $user, chat: $chat, messageString: $messageString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other.chat, chat) &&
            const DeepCollectionEquality()
                .equals(other.messageString, messageString));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(chat),
      const DeepCollectionEquality().hash(messageString));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements ChatScreenState {
  const factory _Initial({User? user, Chat chat, String messageString}) =
      _$_Initial;

  @override
  User? get user;
  @override
  Chat get chat;
  @override
  String get messageString;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
