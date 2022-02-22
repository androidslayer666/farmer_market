import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../repository/auth_repository/auth_repository.dart';
import '../../../../repository/models/product.dart';
import '../../../../repository/products/product_repository.dart';
import 'add_product_event.dart';
import 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc({
    required AuthRepository authRepository,
    required ProductRepository productRepository})
      : _productRepository = productRepository,
        _authRepository = authRepository,
        super(const AddProductState()) {
    on<AddProductNameChanged>(_onNameChanged);
    on<AddProductDescriptionChanged>(_onDescriptionChanged);
    on<AddProductPriceChanged>(_onPriceChanged);
    on<AddProductUnitChanged>(_onUnitChanged);
    on<AddProductImageAddClicked>(_onImageChanged);
    on<AddProductSubmitted>(_onSubmitted);
    on<AddProductInit>(_onInit);
  }

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;

  Future<void> _onInit(
    AddProductInit event,
    Emitter<AddProductState> emit,
  ) async {
    // emit(state.copyWith(isLoading: true, isImageLoading: true));
    // final result = await _authRepository.getCurrentUser();
    // if (result is Success<User>) {
    //   emit(state.copyWith(
    //       existedName:result.data?.name ?? '',
    //       existedDescription: result.data?.description ?? '',
    //       isLoading: false));
    //   emit(state.copyWith(
    //       productImage: await urlToUint8List(
    //         result.data?.avatarUrl,
    //       ),
    //       isImageLoading: false,
    //       isLoading: false,
    //       existedName: null,
    //     existedDescription: null
    //   ));
    // } else {
    //   emit(state.copyWith(isLoading: false, isImageLoading: false));
    // }
  }

  void _onNameChanged(
    AddProductNameChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onDescriptionChanged(
    AddProductDescriptionChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onPriceChanged(
    AddProductPriceChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(price: event.price));
  }

  void _onUnitChanged(
    AddProductUnitChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(unit: event.unit));
  }

  void _onImageChanged(
    AddProductImageAddClicked event,
    Emitter<AddProductState> emit,
  ) async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(productImage: image));
    }
  }

  void _onSubmitted(
    AddProductSubmitted event,
    Emitter<AddProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = await _authRepository.getCurrentUser();
      final result = _productRepository.saveProduct(
          Product(
              name: state.name ?? '',
              userID: '123',
              unit: state.unit ?? Unit.kilos,
              description: state.description ?? '',
              price: int.parse(state.price ?? '0')),
          state.productImage);
      print(result);
      emit(state.copyWith(isLoading: false));
    } catch (_) {}
  }
}
