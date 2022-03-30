part of 'list_product_bloc.dart';

@immutable
abstract class ListProductEvent {
  const ListProductEvent();
}


class ListProductEventPageRequested extends ListProductEvent{
  const ListProductEventPageRequested();
}