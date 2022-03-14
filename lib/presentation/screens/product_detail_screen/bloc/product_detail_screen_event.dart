import 'package:equatable/equatable.dart';

abstract class ProductDetailScreenEvent extends Equatable {
  const ProductDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailScreenOnInit extends ProductDetailScreenEvent {
  final String userId;

  const ProductDetailScreenOnInit(this.userId);
}
