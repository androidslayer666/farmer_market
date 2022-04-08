part of 'user_products_bloc.dart';

abstract class UserProductsEvent extends Equatable {
  const UserProductsEvent();

  @override
  List<Object?> get props => [];
}


class UserProductsEventInit extends UserProductsEvent{
  const UserProductsEventInit();

  @override
  List<Object?> get props => [];
}


class UserProductsEventUpdateList extends UserProductsEvent{
  const UserProductsEventUpdateList();

  @override
  List<Object?> get props => [];
}