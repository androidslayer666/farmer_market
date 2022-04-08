// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/filter/filter.dart';
import '../../../../../data/models/product/product.dart';
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
    on<ListProductFilterChanged>(_onFilterChanged);
    on<ListProductEventUpdateList>(_onUpdateList);
    on<ListProductEventRestartPaging>(_onRestartPaging);
  }

  _onPageRequested(ListProductEventPageRequested event,
      Emitter<ListProductState> emit) async {
    if(state.noMoreData != true) {
      _fetchNewPage();
    }
  }

  _onUpdateList (
      ListProductEventUpdateList event,
      Emitter<ListProductState> emit
      ) async {
    emit(state.copyWith(lastDocumentId: null, noMoreData: null));
    final lastDocumentId = state.listProducts.isNotEmpty ? state.listProducts.last.id : '';
    final result = await _productRepository.refreshProducts(
        state.filter, lastDocumentId);
    if (result is Success<List<Product>, String>) {
      emit(state.copyWith(
          listProducts: [...result.data!],
          isNewPortionLoading: false
      ));
    }
  }

  _onRestartPaging(
      ListProductEventRestartPaging event, Emitter<ListProductState> emit
      ){
    emit(state.copyWith(listProducts: [], lastDocumentId: null, noMoreData: null));
     _fetchNewPage();
  }

  _onFilterChanged(
      ListProductFilterChanged event, Emitter<ListProductState> emit) {
    emit(state.copyWith(filter: event.filter, lastDocumentId: null, listProducts: []));
    _fetchNewPage();
  }

  _fetchNewPage() async {
    emit(state.copyWith(isNewPortionLoading: true));
    final lastDocumentId = state.listProducts.isNotEmpty ? state.listProducts.last.id : '';
    final result = await _productRepository.getPageOfProducts(
        state.filter, lastDocumentId);
    if (result is Success<List<Product>, String>) {
      emit(state.copyWith(
          listProducts: [...state.listProducts, ...result.data!],
          isNewPortionLoading: false
      ));
      if(result.data?.isNotEmpty != true) {
        emit(state.copyWith(
            noMoreData: true));
      }
    }
  }

}
