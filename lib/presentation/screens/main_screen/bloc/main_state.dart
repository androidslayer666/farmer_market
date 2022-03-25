import 'package:farmer_market/data/models/cart/cart.dart';
import 'package:farmer_market/data/models/filter/filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/product/product.dart';
import '../../../../data/models/user/user.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState(
      {User? user,
      @Default([]) List<Product> listProducts,
      @Default([]) List<Product> listUserProducts,
      @Default(Cart()) Cart cart,
      String? errorWhileFetchingProducts,
      bool? backButtonPressedWhenStackIsClear,
      @Default([0]) List<int> pageStack,
          @Default(Filter()) Filter filter,
      @Default(false) bool filterSwitchedOn,
      bool? isLoading}) = _Initial;
}
