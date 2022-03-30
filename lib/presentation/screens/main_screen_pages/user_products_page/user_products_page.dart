import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/product_grid_item.dart';
import '../../../shared/product_list_item.dart';
import '../../main_screen/bloc/main_state.dart';
import '../../main_screen/bloc/main_bloc.dart';
import '../../main_screen/main_screen.dart';

class UserProductsPage extends StatelessWidget {
  const UserProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('UserProductsPage rebuild');
    return BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(10),
              child: RefreshIndicator(
                color: Theme.of(context).backgroundColor,
                onRefresh: () async {
                  //bloc.add(const UpdateListProductRequested());
                },
                child:
                    ListView.builder(
                      itemCount: state.listUserProducts.length,
                        itemBuilder: (context, index) => ProductListItem(
                              product: state.listUserProducts[index],
                            )),
              ));
        });
  }
}
