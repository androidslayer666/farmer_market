
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/product/product.dart';



part 'cart_page_state.freezed.dart';

@freezed
class CartPageState with _$CartPageState {
  const factory CartPageState(
      {@Default({}) Map<Product, int> productsWithQty,
         }) = _Initial;
}
