import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/api/address.dart';
import '../../../../data/models/api/suggestion.dart';
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
        user: event.user,
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
    emit(state.copyWith(user: state.user?.copyWith(name: event.name)));
  }

  void _onDescriptionChanged(
    UserDetailDescriptionChanged event,
    Emitter<EditUserState> emit,
  ) {
    final description = event.description;
    emit(state.copyWith(user: state.user?.copyWith(description: description)));
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
    Uint8List? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(avatarFile: image));
    }
  }

  void _onUserDetailAddressOptionSubmitted(
    UserDetailAddressOptionSubmitted event,
    Emitter<EditUserState> emit,
  ) {
    emit(state.copyWith(user: state.user?.copyWith(address: event.address)));
  }

  void _onSubmitted(
    UserDetailSubmitted event,
    Emitter<EditUserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      if (state.user != null) {
        await _authRepository.addUserInfo(state.user!, state.avatarFile);
      }
      emit(state.copyWith(
          userDetailStatus: UserDetailStatus.success, isLoading: false));
    } catch (_) {
      emit(state.copyWith(
          userDetailStatus: UserDetailStatus.failure, isLoading: false));
    }
  }
}
