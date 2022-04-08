import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/product/product.dart';
import '../../../../data/models/review/review.dart';
import '../../../../data/models/user/user.dart';

part 'product_detail_screen_state.freezed.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState(
      {User? user,
      Product? product,
      bool? problemWithFetchingUser,
      @Default(Review()) Review review,
      @Default(false) bool showReview}) = _Initial;
}
