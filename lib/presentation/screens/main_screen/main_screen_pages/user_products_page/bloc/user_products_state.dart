import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../data/models/product/product.dart';

part 'user_products_state.freezed.dart';

@freezed
class UserProductsState with _$UserProductsState {
  const factory UserProductsState({@Default([]) List<Product> listProducts, bool? isLoading}) =
      _Initial;
}
