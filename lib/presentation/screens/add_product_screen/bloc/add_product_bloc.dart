import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:image_picker/image_picker.dart';

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
  }

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;

  Future<void> _onInit(
    AddProductInit event,
    Emitter<AddProductState> emit,
  ) async {
    if (event.args != null) {
      print(event.args?.product);
      final product = event.args!.product;
      emit(state.copyWith(
          name: product?.name,
          description: product?.description,
          price: product?.price.toString(),
          unit: product?.unit,
          pictureUrl: product?.pictureUrl,
          id: product?.id));
      emit(state.copyWith(
          productImage: await urlToUint8List(product?.pictureUrl)));
    }
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

  void _onCategoryChanged(
    AddProductCategoryChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(category: event.category));
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
    final userId = _authRepository.getUserId();
    final product = Product(
        id: state.id,
        name: state.name ?? '',
        userID: userId,
        unit: state.unit ?? Unit.kilos,
        pictureUrl: state.pictureUrl,
        description: state.description ?? '',
        price: int.parse(state.price ?? '0'),
        category: state.category);
    print(product);
    final result =
        await _productRepository.saveProduct(product, state.productImage);
    emit(state.copyWith(
        isLoading: false, addingIsSuccessful: result is Success));
  }

  Future<void> _addProductDeleteSubmitted(
    AddProductDeleteSubmitted event,
    Emitter<AddProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _productRepository.deleteProducts(event.uid);
    emit(state.copyWith(
        isLoading: false, deletingIsSuccessful: result is Success));
  }
}
