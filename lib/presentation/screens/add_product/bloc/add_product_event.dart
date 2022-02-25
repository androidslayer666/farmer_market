import 'package:equatable/equatable.dart';

import '../../../../repository/models/product/product.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductInit extends AddProductEvent{
  const AddProductInit();
}

class AddProductNameChanged extends AddProductEvent {
  const AddProductNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class AddProductPriceChanged extends AddProductEvent {
  const AddProductPriceChanged(this.price);

  final String price;

  @override
  List<Object> get props => [price];
}

class AddProductUnitChanged extends AddProductEvent {
  const AddProductUnitChanged(this.unit);

  final Unit unit;

  @override
  List<Object> get props => [unit];
}

class AddProductDescriptionChanged extends AddProductEvent {
  const AddProductDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class AddProductImageAddClicked extends AddProductEvent {
  const AddProductImageAddClicked();

  @override
  List<Object> get props => [];
}

class AddProductSubmitted extends AddProductEvent {
  const AddProductSubmitted();
}
