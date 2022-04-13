import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/product/product.dart';
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
  bool showNoData = false;
  bool noMoreData = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        _listProductBloc.add(const ListProductEventPageRequested());
      }
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          noMoreData) {
        setState(() {
          showNoData = true;
        });
      } else {
        setState(() {
          showNoData = false;
        });
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
      noMoreData = state.noMoreData ?? false;
    }, builder: (context, state) {
      return ListProductsList(
          listProducts: state.listProducts,
          isNewPortionLoading: state.isNewPortionLoading ?? false,
          scrollController: _scrollController,
          showNoData: showNoData);
    });
  }
}

class ListProductsList extends StatelessWidget {
  const ListProductsList(
      {Key? key,
      required this.showNoData,
      required this.scrollController,
      required this.listProducts,
      required this.isNewPortionLoading})
      : super(key: key);

  final List<Product> listProducts;
  final bool showNoData;
  final bool isNewPortionLoading;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final _listProductBloc = context.read<ListProductBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RefreshIndicator(
        color: Theme.of(context).backgroundColor,
        onRefresh: () async {
          _listProductBloc.add(const ListProductEventRestartPaging());
        },
        child: Stack(children: [
          Column(
            children: [
              if (listProducts.isEmpty && isNewPortionLoading != true)
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                      'There are no items matching either your filter or address',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade500)),
                )),
              if (listProducts.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    itemCount: listProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductGridItem(
                        product: listProducts[index],
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                  ),
                ),
              if (showNoData)
                const SizedBox(height: 80, child: Text('no data')),
            ],
          ),
          if (isNewPortionLoading == true)
            const Positioned(
                bottom: 50,
                left: 0,
                child: SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator())))
        ]),
      ),
    );
  }
}
