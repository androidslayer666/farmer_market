// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChatStateTearOff {
  const _$ChatStateTearOff();

  _Initial call({List<Chat>? chats, Map<Chat, User> mapChatUsers = const {}}) {
    return _Initial(
      chats: chats,
      mapChatUsers: mapChatUsers,
    );
  }
}

/// @nodoc
const $ChatState = _$ChatStateTearOff();

/// @nodoc
mixin _$ChatState {
  List<Chat>? get chats => throw _privateConstructorUsedError;
  Map<Chat, User> get mapChatUsers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res>;
  $Res call({List<Chat>? chats, Map<Chat, User> mapChatUsers});
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res> implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  final ChatState _value;
  // ignore: unused_field
  final $Res Function(ChatState) _then;

  @override
  $Res call({
    Object? chats = freezed,
    Object? mapChatUsers = freezed,
  }) {
    return _then(_value.copyWith(
      chats: chats == freezed
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>?,
      mapChatUsers: mapChatUsers == freezed
          ? _value.mapChatUsers
          : mapChatUsers // ignore: cast_nullable_to_non_nullable
              as Map<Chat, User>,
    ));
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({List<Chat>? chats, Map<Chat, User> mapChatUsers});
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$ChatStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? chats = freezed,
    Object? mapChatUsers = freezed,
  }) {
    return _then(_Initial(
      chats: chats == freezed
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>?,
      mapChatUsers: mapChatUsers == freezed
          ? _value.mapChatUsers
          : mapChatUsers // ignore: cast_nullable_to_non_nullable
              as Map<Chat, User>,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.chats, this.mapChatUsers = const {}});

  @override
  final List<Chat>? chats;
  @JsonKey()
  @override
  final Map<Chat, User> mapChatUsers;

  @override
  String toString() {
    return 'ChatState(chats: $chats, mapChatUsers: $mapChatUsers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            const DeepCollectionEquality()
                .equals(other.mapChatUsers, mapChatUsers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(chats),
      const DeepCollectionEquality().hash(mapChatUsers));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);
}

abstract class _Initial implements ChatState {
  const factory _Initial({List<Chat>? chats, Map<Chat, User> mapChatUsers}) =
      _$_Initial;

  @override
  List<Chat>? get chats;
  @override
  Map<Chat, User> get mapChatUsers;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
