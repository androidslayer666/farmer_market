import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/product_grid_item.dart';
import 'bloc/list_product_bloc.dart';
import 'bloc/list_product_state.dart';

class ListProductsPage extends StatefulWidget {
  const ListProductsPage({Key? key}) : super(key: key);

  @override
  State<ListProductsPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  late final ListProductBloc _listProductBloc;
  late final ScrollController _scrollController;

  bool isLoading = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        _listProductBloc.add(ListProductEventPageRequested());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _listProductBloc = context.read<ListProductBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListProductBloc, ListProductState>(
        listener: (context, state) {
      isLoading = state.isNewPortionLoading ?? false;
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: RefreshIndicator(
          color: Theme.of(context).backgroundColor,
          onRefresh: () async {
            //todo: drop state and fetch new data
            //bloc.add(ListProductEventPageRequested());
          },
          child: Stack(children: [
            GridView.builder(
              controller: _scrollController,
              itemCount: state.listProducts.length +
                  (state.noMoreData == true ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index < state.listProducts.length) {
                  return ProductGridItem(
                    product: state.listProducts[index],
                  );
                } else {
                  return const Text('no more items');
                }
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
            ),
            if (state.isNewPortionLoading == true)
              const Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                      height: 80,
                      child: Center(child: CircularProgressIndicator())))
          ]),
        ),
      );
    });
  }
}
