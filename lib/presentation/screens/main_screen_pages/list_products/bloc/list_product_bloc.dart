import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/filter/filter.dart';
import '../../../../../data/models/product/product.dart';
import '../../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../../data/repository/cart_repository/cart_repository.dart';
import '../../../../../data/repository/product_repository/product_repository.dart';
import '../../../../../data/repository/success_failure.dart';
import 'list_product_state.dart';

part 'list_product_event.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  final ProductRepository _productRepository;

  ListProductBloc({
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(const ListProductState()) {
    on<ListProductEventPageRequested>(_onPageRequested);
  }

  void _onPageRequested(ListProductEventPageRequested event,
      Emitter<ListProductState> emit) async {
    emit(state.copyWith(isNewPortionLoading: true));
    final result = await _productRepository.getPageOfProducts(
        const Filter(), state.lastDocumentId);
    if (result is Success<List<Product>, String>) {
      emit(state.copyWith(
          listProducts: [...state.listProducts, ...result.data!],
          isNewPortionLoading: false
      ));
      if(result.data?.isNotEmpty == true) {
        emit(state.copyWith(
            lastDocumentId: result.data![result.data!.length - 1].id));
      } else {
        emit(state.copyWith(
            noMoreData: true));
      }
    }
  }
}
