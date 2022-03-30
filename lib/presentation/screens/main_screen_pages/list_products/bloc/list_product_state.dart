import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/product/product.dart';

part 'list_product_state.freezed.dart';

@freezed
class ListProductState with _$ListProductState {
  const factory ListProductState({
    String? lastDocumentId,
    @Default([]) List<Product> listProducts,
    bool? isNewPortionLoading,
    bool? noMoreData
  }) = _Initial;
}
