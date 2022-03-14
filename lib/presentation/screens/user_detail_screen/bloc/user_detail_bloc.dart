import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/screens/user_detail_screen/bloc/user_detail_event.dart';
import 'package:farmer_market/presentation/screens/user_detail_screen/bloc/user_detail_state.dart';
import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../data/repository/interfaces/i_address_repository.dart';
import '../../../../data/models/api/address.dart';
import '../../../../data/models/api/suggestion.dart';
import '../../../../data/models/user/user.dart';
import '../../../../data/repository/success_failure.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc({
    required AuthRepository authRepository,
    required IAddressRepository addressRepository,
  })  : _authRepository = authRepository,
        _addressRepository = addressRepository,
        super(const UserDetailState()) {
    on<UserDetailNameChanged>(_onNameChanged);
    on<UserDetailDescriptionChanged>(_onDescriptionChanged);
    on<UserDetailImageAddClicked>(_onImageChanged);
    on<UserDetailSubmitted>(_onSubmitted);
    on<UserDetailInit>(_onInit);
    on<UserDetailLogOutClicked>(_onLogOutClicked);
    on<UserDetailAddressChanged>(_onAddressChanged);
    on<UserDetailAddressOptionSubmitted>(_onUserDetailAddressOptionSubmitted);
  }

  final AuthRepository _authRepository;
  final IAddressRepository _addressRepository;

  Future<void> _onInit(
    UserDetailInit event,
    Emitter<UserDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isImageLoading: true));
    final result = await _authRepository.getCurrentUser();
    if (result is Success<User, String>) {
      emit(state.copyWith(
          haveUserInfoOnServer: true,
          name: event.user?.name,
          addressQuery: event.user?.address.toString(),
          description: event.user?.description,
          isLoading: false));
      emit(state.copyWith(
          avatarFile: await urlToUint8List(
            result.data?.avatarUrl,
          ),
          isImageLoading: false,
          isLoading: false));
    } else {
      emit(state.copyWith(
          isLoading: false,
          isImageLoading: false,
          userDetailStatus: UserDetailStatus.failure,
          haveUserInfoOnServer: false));
    }
  }

  void _onLogOutClicked(
    UserDetailLogOutClicked event,
    Emitter<UserDetailState> emit,
  ) {
    _authRepository.signOut();
    emit(state.copyWith(logOutIsClicked: true));
  }

  void _onNameChanged(
    UserDetailNameChanged event,
    Emitter<UserDetailState> emit,
  ) {
    final name = event.name;
    if (state.name != null) {}
    emit(state.copyWith(name: name));
  }

  void _onDescriptionChanged(
    UserDetailDescriptionChanged event,
    Emitter<UserDetailState> emit,
  ) {
    final description = event.description;
    emit(state.copyWith(description: description));
  }

  void _onAddressChanged(
    UserDetailAddressChanged event,
    Emitter<UserDetailState> emit,
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
    Emitter<UserDetailState> emit,
  ) async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(avatarFile: image));
    }
  }

  void _onUserDetailAddressOptionSubmitted(
    UserDetailAddressOptionSubmitted event,
    Emitter<UserDetailState> emit,
  ) {
    emit(state.copyWith(address: event.address));
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
        //final position = await getPosition();
        await _authRepository.addUserInfo(
            User(
              name: state.name ?? '',
              description: state.description ?? '',
              isSeller: false,
              address: state.address,
            ),
            state.avatarFile);
        emit(state.copyWith(
            userDetailStatus: UserDetailStatus.success, isLoading: false));
      } catch (_) {
        emit(state.copyWith(
            userDetailStatus: UserDetailStatus.failure, isLoading: false));
      }
    }
  }
}
