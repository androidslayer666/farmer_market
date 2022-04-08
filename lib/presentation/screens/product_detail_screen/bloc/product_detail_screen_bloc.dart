// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:farmer_market/data/repository/product_repository/product_repository.dart';
import 'package:farmer_market/data/repository/success_failure.dart';
import 'package:farmer_market/data/repository/user_repository/user_repository.dart';
import 'package:farmer_market/presentation/screens/product_detail_screen/bloc/product_detail_screen_event.dart';
import 'package:farmer_market/presentation/screens/product_detail_screen/bloc/product_detail_screen_state.dart';

import '../../../../data/models/product/product.dart';
import '../../../../data/models/user/user.dart' as models;

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final UserRepository _userRepository;
  final ProductRepository _productRepository;

  ProductDetailBloc(ProductDetailState initialState,
      UserRepository userRepository, ProductRepository productRepository)
      : _userRepository = userRepository,
        _productRepository = productRepository,
        super(initialState) {
    on<ProductDetailOnInit>(_productDetailScreenOnInit);
    on<ProductDetailToggleReview>(_onToggleReview);
    on<ProductDetailReviewRateChanged>(_onReviewRateChanged);
    on<ProductDetailReviewTextChanged>(_onReviewTextChanged);
    on<ProductDetailAddReviewClicked>(_onAddReviewClicked);
  }

  _productDetailScreenOnInit(
    ProductDetailOnInit event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(state.copyWith(product: event.product));
    final result =
        await _userRepository.getUserById(event.product?.userID ?? '');
    if (result is Success<models.User, String>) {
      emit(state.copyWith(user: result.data, product: event.product));
    } else {
      emit(state.copyWith(
          problemWithFetchingUser: true, product: event.product));
    }
  }

  _onToggleReview(
    ProductDetailToggleReview event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(showReview: !state.showReview));
  }

  _onReviewRateChanged(
    ProductDetailReviewRateChanged event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(review: state.review.copyWith(rate: event.rate)));
  }

  _onReviewTextChanged(
    ProductDetailReviewTextChanged event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(review: state.review.copyWith(message: event.text)));
  }

  _onAddReviewClicked(
    ProductDetailAddReviewClicked event,
    Emitter<ProductDetailState> emit,
  ) {
    _productRepository.addReview(state.review, state.product?.id?? '');
    _refreshProduct();
  }

  _refreshProduct() async {
    final result = await  _productRepository.getProductById(state.product?.id ?? '');
    if (result is Success<Product, String>) {
      emit(state.copyWith(product: result.data!.copyWith(name: ''), showReview: false));
    }
  }
}
