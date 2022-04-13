import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/shared/utils.dart';

import '../../../../data/models/product/product.dart';
import '../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../data/repository/product_repository/product_repository.dart';
import '../../../../data/repository/success_failure.dart';
import 'add_product_event.dart';
import 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc(
      {required AuthRepository authRepository,
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
    on<AddProductDeleteSubmitted>(_addProductDeleteSubmitted);
    on<AddProductCategoryChanged>(_onCategoryChanged);
    on<AddProductPortionChanged>(_onPortionChanged);
  }

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;

  _onInit(
    AddProductInit event,
    Emitter<AddProductState> emit,
  ) async {
    if (event.args != null) {
      final product = event.args!.product;
      emit(state.copyWith(
          product: event.args!.product ?? const Product(),
          priceIsValid: true,
          descriptionIsValid: true,
          nameIsValid: true,
          categoryIsValid: true,
          measureIsValid: true,
          pictureUrl: product?.pictureUrl,
          isImageLoading: true,
          id: product?.id));
      emit(state.copyWith(
          productImage: await urlToUint8List(product?.pictureUrl), isImageLoading: false));
    } else {
      emit(state.copyWith(product: const Product()));
    }
  }

  _onNameChanged(
    AddProductNameChanged event,
    Emitter<AddProductState> emit,
  ) {
    if (event.name.length < 50 && event.name.isNotEmpty) {
      emit(state.copyWith(
          nameIsValid: true,
          product: state.product?.copyWith(name: event.name),
          saveClickedWhenInputIsNotValid: false));
    } else {
      emit(state.copyWith(nameIsValid: false));
    }
  }

  _onDescriptionChanged(
    AddProductDescriptionChanged event,
    Emitter<AddProductState> emit,
  ) {
    if (event.description.length < 1000) {
      emit(state.copyWith(
          descriptionIsValid: true,
          product: state.product?.copyWith(description: event.description),
          saveClickedWhenInputIsNotValid: false));
    } else {
      emit(state.copyWith(descriptionIsValid: false));
    }
  }

  _onPriceChanged(
    AddProductPriceChanged event,
    Emitter<AddProductState> emit,
  ) {
    if (event.price.isNotEmpty &&
        event.price.length < 12 &&
        int.parse(event.price) > 0) {
      emit(state.copyWith(
          priceIsValid: true,
          product: state.product?.copyWith(price: int.parse(event.price)),
          saveClickedWhenInputIsNotValid: false));
    } else {
      emit(state.copyWith(priceIsValid: false));
    }
  }

  _onUnitChanged(
    AddProductUnitChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(product: state.product?.copyWith(unit: event.unit)));
  }

  _onPortionChanged(
    AddProductPortionChanged event,
    Emitter<AddProductState> emit,
  ) {
    if (event.portion.isNotEmpty &&
        int.parse(event.portion) < 1000 &&
        int.parse(event.portion) > 0) {
      emit(state.copyWith(
          measureIsValid: true,
          product: state.product?.copyWith(portion: int.parse(event.portion)),
          saveClickedWhenInputIsNotValid: false));
    } else {
      emit(state.copyWith(measureIsValid: false));
    }
  }

  _onCategoryChanged(
    AddProductCategoryChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(
        product: state.product?.copyWith(category: event.category)));
  }

  _onImageChanged(
    AddProductImageAddClicked event,
    Emitter<AddProductState> emit,
  ) async {
    Uint8List? image = await pickImage(event.imageSource);
    if (image != null) {
      emit(state.copyWith(productImage: image));
    }
  }

  _onSubmitted(
    AddProductSubmitted event,
    Emitter<AddProductState> emit,
  ) async {
    if (state.measureIsValid == true &&
        state.priceIsValid == true &&
        state.descriptionIsValid == true &&
        state.nameIsValid == true) {
      emit(state.copyWith(isLoading: true));
      final userId = _authRepository.getUserId();
      final product = state.product?.copyWith(userID: userId);
      if (product != null) {
        final result =
            await _productRepository.saveProduct(product, state.productImage);
        emit(state.copyWith(
            isLoading: false, addingIsSuccessful: result is Success));
      }
    } else {
      emit(state.copyWith(saveClickedWhenInputIsNotValid: true));
    }
  }

  _addProductDeleteSubmitted(
    AddProductDeleteSubmitted event,
    Emitter<AddProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _productRepository.deleteProducts(event.uid);
    emit(state.copyWith(
        isLoading: false, deletingIsSuccessful: result is Success));
  }
}
