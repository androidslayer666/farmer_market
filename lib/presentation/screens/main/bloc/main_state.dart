import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/repository/models/product/product.dart';
import '../../../../data/repository/models/user/user.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState(
      {User? user,
      @Default([]) List<Product> listProducts,
      String? errorWhileFetchingProducts,
      bool? isLoading}) = _Initial;

}
