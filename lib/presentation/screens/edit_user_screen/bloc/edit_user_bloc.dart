import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/shared/utils.dart';

import '../../../../data/models/api/address.dart';
import '../../../../data/models/api/suggestion.dart';
import '../../../../data/models/user/user.dart';
import '../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../data/repository/interfaces/i_address_repository.dart';
import '../../../../data/repository/success_failure.dart';
import '../../edit_user_screen/bloc/edit_user_event.dart';
import '../../edit_user_screen/bloc/edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  EditUserBloc({
    required AuthRepository authRepository,
    required IAddressRepository addressRepository,
  })  : _authRepository = authRepository,
        _addressRepository = addressRepository,
        super(const EditUserState()) {
    on<UserDetailNameChanged>(_onNameChanged);
    on<UserDetailDescriptionChanged>(_onDescriptionChanged);
    on<UserDetailImageAddClicked>(_onImageChanged);
    on<UserDetailSubmitted>(_onSubmitted);
    on<UserDetailInit>(_onInit);
    on<UserDetailLogOutClicked>(_onLogOutClicked);
    on<UserDetailAddressChanged>(_onAddressChanged);
    on<UserDetailAddressOptionSubmitted>(_onUserDetailAddressOptionSubmitted);
    on<UserDetailIsSellerChanged>(_onIsSellerChanged);
  }

  final AuthRepository _authRepository;
  final IAddressRepository _addressRepository;

  _onInit(
    UserDetailInit event,
    Emitter<EditUserState> emit,
  ) async {
    emit(state.copyWith(
        isImageLoading: true,
        user: event.user ?? const User(),
        nameIsValid: true,
        descriptionIsValid: true,
        addressIsValid: true,
        addressQuery: event.user?.address.toString()));

    emit(state.copyWith(
      avatarFile: await urlToUint8List(
        event.user?.avatarUrl,
      ),
      isImageLoading: false,
    ));
  }

  _onIsSellerChanged(
    UserDetailIsSellerChanged event,
    Emitter<EditUserState> emit,
  ) {
    emit(state.copyWith(user: state.user?.copyWith(isSeller: event.isSeller)));
  }

  void _onLogOutClicked(
    UserDetailLogOutClicked event,
    Emitter<EditUserState> emit,
  ) {
    _authRepository.signOut();
    emit(state.copyWith(logOutIsClicked: true));
  }

  void _onNameChanged(
    UserDetailNameChanged event,
    Emitter<EditUserState> emit,
  ) {
    if (event.name.length < 50 && event.name.isNotEmpty) {
      emit(state.copyWith(
          nameIsValid: true,
          user: state.user?.copyWith(name: event.name),
          saveClickedWhenInputIsNotValid: false));
    } else {
      emit(state.copyWith(nameIsValid: false));
    }
  }

  void _onDescriptionChanged(
    UserDetailDescriptionChanged event,
    Emitter<EditUserState> emit,
  ) {
    if (event.description.length < 1000) {
      emit(state.copyWith(
          descriptionIsValid: true,
          user: state.user?.copyWith(description: event.description),
          saveClickedWhenInputIsNotValid: false));
    } else {
      emit(state.copyWith(descriptionIsValid: false));
    }
  }

  void _onAddressChanged(
    UserDetailAddressChanged event,
    Emitter<EditUserState> emit,
  ) async {
    final address = event.address;
    final response = await _addressRepository.getSuggestions(event.address);
    if (response is Success<List<Suggestion>, String>) {
      final finalList =
          response.data?.map((e) => e.data).whereType<Address>().toList();
      emit(state.copyWith(addressQuery: address, addresses: finalList));
    } else {
      emit(state.copyWith(addressQuery: address));
    }
  }

  void _onImageChanged(
    UserDetailImageAddClicked event,
    Emitter<EditUserState> emit,
  ) async {
    Uint8List? image = await pickImage(event.imageSource);
    if (image != null) {
      emit(state.copyWith(avatarFile: image));
    }
  }

  void _onUserDetailAddressOptionSubmitted(
    UserDetailAddressOptionSubmitted event,
    Emitter<EditUserState> emit,
  ) {
    emit(state.copyWith(
        user: state.user?.copyWith(address: event.address),
        addressIsValid: true,
        saveClickedWhenInputIsNotValid: false));
  }

  // todo: add uid
  void _onSubmitted(
    UserDetailSubmitted event,
    Emitter<EditUserState> emit,
  ) async {
    if (state.nameIsValid == true &&
        state.descriptionIsValid == true &&
        state.user?.address != null) {
      emit(state.copyWith(isLoading: true));

      try {
        if (state.user != null) {
          final user = state.user!.copyWith(id: _authRepository.getUserId());
          await _authRepository.addUserInfo(user, state.avatarFile);
        }
        emit(state.copyWith(
            changesSaved: true, isLoading: false));
      } catch (_) {
        emit(state.copyWith(
            changesSaved: false, isLoading: false));
      }
    } else if (state.user?.address == null) {
      emit(state.copyWith(
          addressIsValid: false, saveClickedWhenInputIsNotValid: true));
    } else {
      emit(state.copyWith(saveClickedWhenInputIsNotValid: true));
      emit(state.copyWith(saveClickedWhenInputIsNotValid: false));
    }
  }
}
