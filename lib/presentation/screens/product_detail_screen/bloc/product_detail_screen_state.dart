import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/user/user.dart';

part 'product_detail_screen_state.freezed.dart';

@freezed
class ProductDetailScreenState with _$ProductDetailScreenState {
  const factory ProductDetailScreenState({
    User? user,
    bool? problemWithFetchingUser
  }) = _Initial;
}
