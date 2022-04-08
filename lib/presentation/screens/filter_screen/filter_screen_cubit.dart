import 'package:bloc/bloc.dart';
import 'package:farmer_market/data/repository/product_repository/product_repository.dart';
import 'package:farmer_market/data/repository/user_repository/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/filter/filter.dart';
import '../../../data/models/product/category.dart';
import '../../../data/models/product/product.dart';
import '../../../data/models/user/user.dart';
import '../../../data/repository/success_failure.dart';

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

  void setBottomPrice(int price) {
    emit(state.copyWith(filter: state.filter.copyWith(bottomPrice: price)));
  }

  void setTopPrice(int price) {
    emit(state.copyWith(filter: state.filter.copyWith(topPrice: price)));
  }

  void clearFilters() {
    emit(state.copyWith(filter: const Filter()));
  }
}
