part of 'list_product_bloc.dart';

@immutable
abstract class ListProductEvent {
  const ListProductEvent();
}


class ListProductEventPageRequested extends ListProductEvent{
  const ListProductEventPageRequested();
}

class ListProductEventUpdateList extends ListProductEvent{
  const ListProductEventUpdateList();
}

class ListProductFilterChanged extends ListProductEvent {
  const ListProductFilterChanged(this.filter);

  final Filter filter;

  @override
  List<Object> get props => [filter];
}

class ListProductEventRestartPaging extends ListProductEvent{
  const ListProductEventRestartPaging();
}