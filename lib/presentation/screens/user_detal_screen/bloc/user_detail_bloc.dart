import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/user_detal_screen/bloc/user_detail_event.dart';
import 'package:farmer_market/presentation/screens/user_detal_screen/bloc/user_detail_state.dart';

import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:farmer_market/repository/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../repository/auth_repository/auth_repository.dart';
import '../../../../repository/success_failure.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc(
      {required AuthRepository authRepository, required BuildContext context})
      : _authRepository = authRepository,
        super(const UserDetailState()) {
    on<UserDetailNameChanged>(_onNameChanged);
    on<UserDetailPhoneChanged>(_onPhoneChanged);
    on<UserDetailDescriptionChanged>(_onDescriptionChanged);
    on<UserDetailImageAddClicked>(_onImageChanged);
    on<UserDetailSubmitted>(_onSubmitted);
    on<UserDetailInit>(_onInit);
    on<UserDetailLogOutClicked>(_onLogOutClicked);
  }

  final AuthRepository _authRepository;

  Future<void> _onInit(
    UserDetailInit event,
    Emitter<UserDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isImageLoading: true));
    final result = await _authRepository.getCurrentUser();
    if (result is Success<User>) {
      emit(state.copyWith(
          haveUserInfoOnServer: true,
          name: TextEditingController()..text = result.data?.name ?? '',
          description: TextEditingController()..text =  result.data?.description?? '',
          isLoading: false));
      emit(state.copyWith(
          avatarFile: await urlToUint8List(
            result.data?.avatarUrl,
          ),
          isImageLoading: false,
          isLoading: false));
    } else {
      emit(state.copyWith(
          isLoading: false, isImageLoading: false, userDetailStatus: UserDetailStatus.failure, haveUserInfoOnServer: false));
    }
  }

  void _onLogOutClicked(
      UserDetailLogOutClicked event,
      Emitter<UserDetailState> emit,
      ){
    _authRepository.signOut();
    emit(state.copyWith(logOutIsClicked: true));
  }

  void _onNameChanged(
    UserDetailNameChanged event,
    Emitter<UserDetailState> emit,
  ) {
    final name = event.name;
    if(state.name != null){}
    //emit(state.copyWith(name: state.name!.text = name));
  }

  void _onPhoneChanged(
    UserDetailPhoneChanged event,
    Emitter<UserDetailState> emit,
  ) {
    final phone = event.phone;
    //emit(state.copyWith(phone: phone, phoneIsValid: phone.isValidPhone()));
  }

  void _onDescriptionChanged(
    UserDetailDescriptionChanged event,
    Emitter<UserDetailState> emit,
  ) {
    final description = event.description;
    emit(state.copyWith(description: TextEditingController()..text = description));
  }

  void _onImageChanged(
    UserDetailImageAddClicked event,
    Emitter<UserDetailState> emit,
  ) async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(avatarFile: image));
    }
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
                name: state.name?.text ?? '',
                phone: state.phone ?? '',
                description: state.description?.text ?? '',
                isSeller: false),
            state.avatarFile);
        emit(state.copyWith(userDetailStatus: UserDetailStatus.success, isLoading: false));
      } catch (_) {
        emit(state.copyWith(userDetailStatus: UserDetailStatus.failure, isLoading: false));
      }
    }
  }
}
