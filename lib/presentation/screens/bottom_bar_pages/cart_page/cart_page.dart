import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../app/bloc/app_event.dart';
import '../../../../app/bloc/app_state.dart';
import '../../../../data/models/cart/cart_item.dart';
import '../../../../data/models/product/product.dart';
import '../../../../data/models/user/user.dart';
import '../../../shared/utils.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CartPageBody();
  }
}

class CartPageBody extends StatelessWidget {
  const CartPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Column(children: [
        CartList(
          listCartItems: state.cart.cartItems,
        )
      ]);
    });
  }
}

class CartList extends StatelessWidget {
  const CartList({Key? key, required this.listCartItems}) : super(key: key);

  final List<CartItem> listCartItems;

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final listUserIDs = listCartItems.map((e) => e.user).toSet().toList();
    final Map<User?, List<CartItem>> map = {};
    for (final user in listUserIDs) {
      map[user] = listCartItems
          .where((element) => element.product?.userID == user?.id)
          .toList();
    }
    return Column(
        children: map.entries
            .where((element) =>
                element.key?.id != null && element.key?.name != null)
            .map((e) => Column(
                  children: [
                    Text(e.key?.name ?? ''),
                    ...e.value.map((e) => CartItemWidget(item: e)),
                    ElevatedButton(
                        onPressed: () {
                          appBloc.add(AppStateCreateOrderClicked(
                              listCartItems,
                              e.key ?? User(),
                              e.value.first.product?.userID ?? ''));
                        },
                        child: Text('Place order'))
                  ],
                ))
            .toList());
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final bloc = context.read<AppBloc>();
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
          flex: 9,
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: _productDescriptionBuilder(
                        item.product ?? const Product(), locale)),
                Expanded(
                    flex: 4,
                    child: Row(children: [
                      IconButton(
                          onPressed: () {
                            bloc.add(AppStateRemoveFromCart(item.product!));
                          },
                          icon: const Icon(Icons.remove)),
                      Text(item.qty.toString()),
                      IconButton(
                          onPressed: () {
                            bloc.add(
                                AppStateAddToCart(item.product!, item.user!));
                          },
                          icon: const Icon(Icons.add)),
                    ]))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                        '${item.product?.price} x ${item.qty} = ${(item.product?.price != null) ? (item.product!.price! * item.qty) : 0}'),
                  ),
                )
              ],
            ),
          ]),
        ),
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
