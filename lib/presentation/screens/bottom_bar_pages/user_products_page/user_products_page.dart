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
                    // GridView.builder(
                    //   itemCount: state.listUserProducts.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return ProductGridItem(
                    //       product: state.listUserProducts[index],
                    //     );
                    //   },
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //     crossAxisSpacing: 10.0,
                    //     mainAxisSpacing: 10.0,
                    //   ),
                    // ),
                    ListView.builder(
                      itemCount: state.listUserProducts.length,
                        itemBuilder: (context, index) => ProductListItem(
                              product: state.listUserProducts[index],
                            )),
              ));
        });
  }
}
