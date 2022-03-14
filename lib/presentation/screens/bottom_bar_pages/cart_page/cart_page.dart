import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/presentation/screens/bottom_bar_pages/cart_page/bloc/cart_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/di/getit_setup.dart';
import '../../../../data/models/cart/cart_item.dart';
import '../../../../data/models/product/product.dart';
import '../../../../data/repository/auth_repository/auth_repository.dart';
import '../../../../data/repository/products/product_repository.dart';
import '../../../shared/utils.dart';
import '../../main_screen/bloc/main_bloc.dart';
import '../../main_screen/bloc/main_event.dart';
import '../../main_screen/bloc/main_state.dart';
import 'bloc/cart_page_event.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartPageBloc(
          authRepository: locator<AuthRepository>(),
          productRepository: locator<ProductRepository>())
        ..add(const CartPageInit()),
      child: const CartPageBody(),
    );
  }
}

class CartPageBody extends StatelessWidget {
  const CartPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        // buildWhen: (previous, current) => true,
        builder: (context, state) {
          return Column(
              children: [...state.cart.cartItems]
                  .map((e) => CartItemWidget(
                        item: e,
                      ))
                  .toList());
        });
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final bloc = context.read<MainBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: item.product?.pictureUrl != null
                ? CachedNetworkImage(
                    imageUrl: item.product!.pictureUrl!,
                    height: 100,
                  )
                : Image.asset('assets/images/placeholder-image.png')),
        Expanded(
            flex: 5, child: _productDescriptionBuilder(item.product ?? Product(), locale)),
        Expanded(
            flex: 4,
            child: Row(children: [
              IconButton(onPressed: (){bloc.add(MainScreenRemoveFromCart(item.product!));}, icon: const Icon(Icons.remove)),
              Text(item.qty != null ? item.qty.toString() : ''),
              IconButton(onPressed: (){bloc.add(MainScreenAddToCart(item.product!));}, icon: const Icon(Icons.add)),
            ]))
      ],
    );
  }
}

Widget _productDescriptionBuilder(Product product, Locale locale) {
  final formatCurrency = NumberFormat.simpleCurrency(locale: locale.toString());
  return Center(
      child: Column(children: [
    Text((product.name ?? '') +
        ', ' +
        product.price.toString() +
        // because of the ruble sign is not supported in intl 0.17.0 there is a custom function
        getCurrencySign(formatCurrency, locale)),
  ]));
}
