import 'package:freezed_annotation/freezed_annotation.dart';

import '../cart/cart_item.dart';
import '../convertors.dart';

part 'order.freezed.dart';

part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order(
      {String? id,
      String? shipperId,
      String? purchaserId,
      @JsonKey(toJson: listCartItemsToJson)
      @Default([])
          List<CartItem> cartItems,
        DateTime? confirmedShippingDate,
      DateTime? dateCreated}) = _Initial;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
