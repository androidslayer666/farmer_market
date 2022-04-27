import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/product_list_item.dart';
import 'bloc/user_products_bloc.dart';
import 'bloc/user_products_state.dart';

class UserProductsPage extends StatelessWidget {
  const UserProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserProductsBloc>();
    return BlocConsumer<UserProductsBloc, UserProductsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                color: Theme.of(context).backgroundColor,
                onRefresh: () async {
                  bloc.add(const UserProductsEventUpdateList());
                },
                child: ListView.builder(
                    itemCount: state.listProducts.length,
                    itemBuilder: (context, index) => ProductListItem(
                          product: state.listProducts[index],
                          navigateToEditScreen: true,
                        )),
              ));
        });
  }
}
