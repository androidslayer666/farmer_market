import 'package:equatable/equatable.dart';
import 'package:farmer_market/presentation/navigation/arguments.dart';

import '../../../../data/models/product/category.dart';
import '../../../../data/models/product/product.dart';


abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object?> get props => [];
}

class AddProductInit extends AddProductEvent{
  const AddProductInit(this.args);

  final AddProductArguments? args;

  @override
  List<Object?> get props => [args];
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

class AddProductCategoryChanged extends AddProductEvent {
  const AddProductCategoryChanged(this.category);

  final Category category;

  @override
  List<Object> get props => [category];
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

class AddProductDeleteSubmitted extends AddProductEvent {
  const AddProductDeleteSubmitted(this.uid);

  final String uid;

  @override
  List<Object> get props => [uid];
}