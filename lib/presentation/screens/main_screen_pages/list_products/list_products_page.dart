import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
      if(_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent && noMoreData){
        setState(() {
          showNoData = true;
        });
      } else {setState(() {
        showNoData = false;
      });}
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
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    itemCount: state.listProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductGridItem(
                        product: state.listProducts[index],
                      );
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                  ),
                ),
                if(showNoData)
                  const SizedBox(height: 80,child: Text('no data')),
              ],
            ),

            if (state.isNewPortionLoading == true)
              const Positioned(
                  bottom: 50,
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
