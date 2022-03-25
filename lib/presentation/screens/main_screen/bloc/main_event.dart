import 'package:equatable/equatable.dart';

import '../../../../data/models/filter/filter.dart';
import '../../../../data/models/product/product.dart';
import '../../../../data/models/user/user.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainScreenInit extends MainEvent{
  const MainScreenInit();
}

class MainScreenEditProfileClicked extends MainEvent{
  const MainScreenEditProfileClicked();
}

class MainScreenUpdateListProductRequested extends MainEvent{
  const MainScreenUpdateListProductRequested();
}

class MainScreenBackButtonPressedWhenStackIsClear extends MainEvent{
  const MainScreenBackButtonPressedWhenStackIsClear();
}

class MainScreenBackButtonPressed extends MainEvent{
  const MainScreenBackButtonPressed();
}

class MainScreenTabChanged extends MainEvent{
  const MainScreenTabChanged(this.tabIndex);
  final int tabIndex;

  @override
  List<Object> get props => [tabIndex];
}

class MainScreenAddToCart extends MainEvent{
  const MainScreenAddToCart(this.product, this.user);
  final Product product;
  final User user;

  @override
  List<Object> get props => [product, user];
}

class MainScreenRemoveFromCart extends MainEvent{
  const MainScreenRemoveFromCart(this.product);
  final Product product;

  @override
  List<Object> get props => [product];
}

class MainScreenFilterToggled extends MainEvent{
  const MainScreenFilterToggled();
}

class MainScreenFilterChanged extends MainEvent{
  const MainScreenFilterChanged(this.filter);
  final Filter filter;

  @override
  List<Object> get props => [filter];
}