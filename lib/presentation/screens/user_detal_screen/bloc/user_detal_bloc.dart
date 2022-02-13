import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/user_detal_screen/bloc/user_detal_event.dart';
import 'package:farmer_market/presentation/screens/user_detal_screen/bloc/user_detal_state.dart';

import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:farmer_market/repository/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../repository/auth_repository/auth_repository.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc(
      {required AuthRepository authRepository, required BuildContext context})
      : _authRepository = authRepository,
        _context = context,
        super(const UserDetailState()) {
    on<UserDetailNameChanged>(_onNameChanged);
    on<UserDetailPhoneChanged>(_onPhoneChanged);
    on<UserDetailDescriptionChanged>(_onDescriptionChanged);
    on<UserDetailImageAddClicked>(_onImageChanged);
    on<UserDetailSubmitted>(_onSubmitted);
  }

  final BuildContext _context;
  final AuthRepository _authRepository;

  void _onNameChanged(
    UserDetailNameChanged event,
    Emitter<UserDetailState> emit,
  ) {
    final name = event.name;
    emit(state.copyWith(name: name));
  }

  void _onPhoneChanged(
    UserDetailPhoneChanged event,
    Emitter<UserDetailState> emit,
  ) {
    final phone = event.phone;
    emit(state.copyWith(phone: phone, phoneIsValid: phone.isValidPhone()));
  }

  void _onDescriptionChanged(
    UserDetailDescriptionChanged event,
    Emitter<UserDetailState> emit,
  ) {
    final description = event.description;
    emit(state.copyWith(description: description));
  }

  void _onImageChanged(
    UserDetailImageAddClicked event,
    Emitter<UserDetailState> emit,
  ) async {
    Uint8List im = await pickImage(ImageSource.gallery);
    emit(state.copyWith(image: im));
  }

  void _onSubmitted(
    UserDetailSubmitted event,
    Emitter<UserDetailState> emit,
  ) async {
    if (
        // state.passwordIsValid && state.phoneIsValid
        true) {
      emit(state.copyWith(isLoading: true));
      try {
        await _authRepository.addUserInfo(
            User(
                name: state.name,
                phone: state.phone,
                description: state.description,
                isSeller: false),
            state.image);
        emit(state.copyWith(signInStatus: UserDetailStatus.success));
      } catch (_) {
        emit(state.copyWith(signInStatus: UserDetailStatus.failure));
      }
    }
  }
}
