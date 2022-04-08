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

  Future<void> _onInit(
    AddProductInit event,
    Emitter<AddProductState> emit,
  ) async {
    if (event.args != null) {
      final product = event.args!.product;
      emit(state.copyWith(
          product: event.args!.product ?? const Product(),
          name: product?.name,
          description: product?.description,
          price: product?.price.toString(),
          unit: product?.unit,
          pictureUrl: product?.pictureUrl,
          id: product?.id));
      emit(state.copyWith(
          productImage: await urlToUint8List(product?.pictureUrl)));
    }else {
      emit(state.copyWith(
          product:  const Product()));
    }
  }

  void _onNameChanged(
    AddProductNameChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(product: state.product?.copyWith(name: event.name)));
  }

  void _onDescriptionChanged(
    AddProductDescriptionChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(product: state.product?.copyWith(description: event.description)));
  }

  void _onPriceChanged(
    AddProductPriceChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(product: state.product?.copyWith(price: int.parse(event.price))));
  }

  void _onUnitChanged(
    AddProductUnitChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(product: state.product?.copyWith(unit: event.unit)));
  }

  _onPortionChanged(
      AddProductPortionChanged event,
      Emitter<AddProductState> emit,
      ){
    emit(state.copyWith(product: state.product?.copyWith(portion: event.portion)));
  }

  void _onCategoryChanged(
    AddProductCategoryChanged event,
    Emitter<AddProductState> emit,
  ) {
    emit(state.copyWith(product: state.product?.copyWith(category: event.category)));
  }

  void _onImageChanged(
    AddProductImageAddClicked event,
    Emitter<AddProductState> emit,
  ) async {
    Uint8List? image = await pickImage(event.imageSource);
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
    final product =  state.product?.copyWith(
        userID: userId);
    if(product != null) {
      final result =
      await _productRepository.saveProduct(product, state.productImage);
      emit(state.copyWith(
          isLoading: false, addingIsSuccessful: result is Success));
    }
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
