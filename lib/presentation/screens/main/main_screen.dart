import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_bloc.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_state.dart';
import 'package:farmer_market/repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/getit_setup.dart';
import '../../../repository/models/product.dart';
import '../../../repository/products/product_repository.dart';
import '../../navigation/navigation_wrapper.dart';
import 'bloc/main_event.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
        create: (context) {
          return MainBloc(
              authRepository: locator.get<AuthRepository>(),
              productRepository: locator.get<ProductRepository>())
            ..add(const MainScreenInit());
        },
        child: MainScreenBody());
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainBloc = context.read<MainBloc>();

    return BlocConsumer<MainBloc, MainState>(listener: (context, state) {
      if (state.mainScreenEditProfileClicked == true) {
        navigateToUserDetailScreen(context);
      }
    }, builder: (context, state) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: GestureDetector(
              onTap: () {
                mainBloc.add(const MainScreenEditProfileClicked());
              },
              child: Row(children: [
                CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: state.user?.avatarUrl == null
                        ? null
                        : NetworkImage(state.user!.avatarUrl!)),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.user?.name ?? '',
                        style: const TextStyle(color: Colors.white),
                      )),
                )
              ]),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: state.listProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return ListItem(
                  product: state.listProducts[index],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).backgroundColor,
            onPressed: () {
              navigateToAddProductScreen(context);
            },
            child: const Icon(Icons.add),
          ),
        ),
      );
    });
  }
}

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.product}) : super(key: key);

  final Product product;


  @override
  Widget build(BuildContext context) {
    //print(product);
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 1,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Expanded(
            flex: 5,
            child:
            product.pictureUrl != null ? CachedNetworkImage(imageUrl: product.pictureUrl!) : SizedBox()),
        Expanded(
            flex: 2,
            child: Center(
                child: Column(children: [Text('${product.name}' + ', ' + product.price.toString() + '\u20BD'),
                if(product.address?.city != null)
                  Text('${product.address?.city}')
                ]))),

      ]),
    );
  }
}
