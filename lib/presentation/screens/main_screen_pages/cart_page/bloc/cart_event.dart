part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartEventInit extends CartEvent{
  const CartEventInit();
}

class CartEventAddToCart extends CartEvent{
  const CartEventAddToCart(this.product, this.user);
  final Product product;
  final User user;

  @override
  List<Object> get props => [product, user];
}

class CartEventRemoveFromCart extends CartEvent{
  const CartEventRemoveFromCart(this.product);
  final Product product;

  @override
  List<Object> get props => [product];
}

class CartEventCreateOrderClicked extends CartEvent{
  const CartEventCreateOrderClicked(this.user);
  final User? user;

  @override
  List<Object?> get props => [user];
}