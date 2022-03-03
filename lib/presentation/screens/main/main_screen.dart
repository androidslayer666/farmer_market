import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_bloc.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_state.dart';
import 'package:farmer_market/data/repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../app/di/getit_setup.dart';
import '../../../data/repository/models/product/product.dart';
import '../../../data/repository/products/product_repository.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/utils.dart';
import 'bloc/main_event.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bloc = MainBloc(
      authRepository: locator.get<AuthRepository>(),
      productRepository: locator.get<ProductRepository>())
    ..add(const MainScreenInit());
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
        create: (context) {
          return bloc;
        },
        child: const MainScreenBody());
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainBloc, MainState>(listener: (context, state) {
    }, builder: (context, state) {
      final bloc = context.read<MainBloc>();

      //control back button click behaviour
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: GestureDetector(
              onTap: () {
                // navigate to account screen
                navigateToUserDetailScreen(context);
              },
              child: Row(children: [
                CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: state.user?.avatarUrl != null
                        ? NetworkImage(state.user!.avatarUrl!)
                        : null),
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
            child: RefreshIndicator(
              color: Theme.of(context).backgroundColor,
              onRefresh: () async {
                bloc.add(const UpdateListProductRequested());
              },
              child: GridView.builder(
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
    Locale locale = Localizations.localeOf(context);

    return Card(
      color: Theme.of(context).cardColor,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Expanded(
            flex: 5,
            child: product.pictureUrl != null
                ? CachedNetworkImage(imageUrl: product.pictureUrl!)
                : Image.asset('assets/images/placeholder-image.png')),
        Expanded(
            flex: 2,
            child: _productDescriptionBuilder(product, locale)),
      ]),
    );
  }
}

Widget _productDescriptionBuilder(Product product, Locale locale) {
  final formatCurrency = NumberFormat.simpleCurrency(
      locale: locale.toString());
  return Center(child: Column(children: [
    Text((product.name ?? '') + ', ' +
        product.price.toString() +
        // because of the ruble sign is not supported in intl 0.17.0 there is a custom function
        getCurrencySign(formatCurrency, locale)),
    if (product.address?.city != null)
      Text('${product.address?.city}')
  ]));
}