part of 'shipping_bloc.dart';

abstract class ShippingEvent extends Equatable {
  const ShippingEvent();

  @override
  List<Object?> get props => [];
}

class ShippingEventInit extends ShippingEvent{
  const ShippingEventInit();

}

class ShippingEventCreateOrderClicked extends ShippingEvent{
  const ShippingEventCreateOrderClicked(this.listCartItems, this.user, this.shipperId);
  final List<CartItem> listCartItems;
  final User user;
  final String shipperId;

  @override
  List<Object> get props => [listCartItems, user];
}

class ShippingEventConfirmDateShipping extends ShippingEvent{
  const ShippingEventConfirmDateShipping(this.order, this.dateTime);
  final Order order;
  final DateTime dateTime;

  @override
  List<Object> get props => [order, dateTime];
}