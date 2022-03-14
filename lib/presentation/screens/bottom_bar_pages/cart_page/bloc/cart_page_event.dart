import 'package:equatable/equatable.dart';
import 'package:farmer_market/presentation/navigation/arguments.dart';


abstract class CartPageEvent extends Equatable {
  const CartPageEvent();

  @override
  List<Object?> get props => [];
}

class CartPageInit extends CartPageEvent{
  const CartPageInit();
}

