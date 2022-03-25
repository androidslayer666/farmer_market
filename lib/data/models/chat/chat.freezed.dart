// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Initial.fromJson(json);
}

/// @nodoc
class _$ChatTearOff {
  const _$ChatTearOff();

  _Initial call(
      {String? id,
      @JsonKey(toJson: userToJson) User? user,
      @JsonKey(toJson: listMessagesToJson) List<Message>? listMessages}) {
    return _Initial(
      id: id,
      user: user,
      listMessages: listMessages,
    );
  }

  Chat fromJson(Map<String, Object?> json) {
    return Chat.fromJson(json);
  }
}

/// @nodoc
const $Chat = _$ChatTearOff();

/// @nodoc
mixin _$Chat {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(toJson: userToJson)
  User? get user => throw _privateConstructorUsedError;
  @JsonKey(toJson: listMessagesToJson)
  List<Message>? get listMessages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      @JsonKey(toJson: userToJson) User? user,
      @JsonKey(toJson: listMessagesToJson) List<Message>? listMessages});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$ChatCopyWithImpl<$Res> implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  final Chat _value;
  // ignore: unused_field
  final $Res Function(Chat) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? listMessages = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      listMessages: listMessages == freezed
          ? _value.listMessages
          : listMessages // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
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
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      @JsonKey(toJson: userToJson) User? user,
      @JsonKey(toJson: listMessagesToJson) List<Message>? listMessages});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$ChatCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? listMessages = freezed,
  }) {
    return _then(_Initial(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      listMessages: listMessages == freezed
          ? _value.listMessages
          : listMessages // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Initial implements _Initial {
  const _$_Initial(
      {this.id,
      @JsonKey(toJson: userToJson) this.user,
      @JsonKey(toJson: listMessagesToJson) this.listMessages});

  factory _$_Initial.fromJson(Map<String, dynamic> json) =>
      _$$_InitialFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(toJson: userToJson)
  final User? user;
  @override
  @JsonKey(toJson: listMessagesToJson)
  final List<Message>? listMessages;

  @override
  String toString() {
    return 'Chat(id: $id, user: $user, listMessages: $listMessages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality()
                .equals(other.listMessages, listMessages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(listMessages));

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InitialToJson(this);
  }
}

abstract class _Initial implements Chat {
  const factory _Initial(
          {String? id,
          @JsonKey(toJson: userToJson) User? user,
          @JsonKey(toJson: listMessagesToJson) List<Message>? listMessages}) =
      _$_Initial;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$_Initial.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(toJson: userToJson)
  User? get user;
  @override
  @JsonKey(toJson: listMessagesToJson)
  List<Message>? get listMessages;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
