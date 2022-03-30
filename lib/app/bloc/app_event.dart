

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

