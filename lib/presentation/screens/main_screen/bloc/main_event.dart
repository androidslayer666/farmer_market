import 'package:equatable/equatable.dart';

import '../../../../data/models/product/product.dart';

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
  const MainScreenAddToCart(this.product);
  final Product product;

  @override
  List<Object> get props => [product];
}

class MainScreenRemoveFromCart extends MainEvent{
  const MainScreenRemoveFromCart(this.product);
  final Product product;

  @override
  List<Object> get props => [product];
}

