import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/filter/filter.dart';
import '../../../data/models/product/category.dart';

part 'filter_screen_cubit.freezed.dart';

@freezed
class FilterScreenState with _$FilterScreenState {
  const factory FilterScreenState({@Default(Filter()) Filter filter}) =
      _Initial;
}

class FilterScreenCubit extends Cubit<FilterScreenState> {
  FilterScreenCubit(Filter? filter)
      : super(FilterScreenState(filter: filter ?? const Filter()));

  void addOrRemoveCategory(Category category) {
    Filter? filter;
    if (state.filter.categories == null) {
      filter = state.filter.copyWith(categories: [category]);
    } else if (state.filter.categories?.contains(category) != true) {
      filter = state.filter
          .copyWith(categories: [...?state.filter.categories, category]);
    } else {
      filter = state.filter.copyWith(
          categories: [...?state.filter.categories]..remove(category));
    }
    emit(state.copyWith(filter: filter));
  }

  void setBottomPrice(String price) {
    emit(state.copyWith(
        filter: state.filter
            .copyWith(bottomPrice: price.isEmpty ? null : int.parse(price))));
  }

  void setTopPrice(String price) {
    emit(state.copyWith(
        filter: state.filter
            .copyWith(topPrice: price.isEmpty ? null : int.parse(price))));
  }

  void clearFilters() {
    emit(state.copyWith(filter: const Filter()));
  }
}
