

import 'package:equatable/equatable.dart';

import '../../data/models/cart/cart_item.dart';
import '../../data/models/order/order.dart';
import '../../data/models/product/product.dart';
import '../../data/models/user/user.dart';
import 'app_state.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppEventAppLaunched extends AppEvent {
  const AppEventAppLaunched();
}

class AppAuthStatusChanged extends AppEvent {
  const AppAuthStatusChanged(this.authenticated);

  final bool authenticated;
}

class InitialLaunch extends AppEvent{
  const InitialLaunch();
}

class AppStateAddToCart extends AppEvent{
  const AppStateAddToCart(this.product, this.user);
  final Product product;
  final User user;

  @override
  List<Object> get props => [product, user];
}

class AppStateRemoveFromCart extends AppEvent{
  const AppStateRemoveFromCart(this.product);
  final Product product;

  @override
  List<Object> get props => [product];
}

class AppStateCreateOrderClicked extends AppEvent{
  const AppStateCreateOrderClicked(this.listCartItems, this.user, this.shipperId);
  final List<CartItem> listCartItems;
  final User user;
  final String shipperId;

  @override
  List<Object> get props => [listCartItems, user];
}

class AppStateConfirmDateShipping extends AppEvent{
  const AppStateConfirmDateShipping(this.order, this.dateTime);
  final Order order;
  final DateTime dateTime;

  @override
  List<Object> get props => [order, dateTime];
}