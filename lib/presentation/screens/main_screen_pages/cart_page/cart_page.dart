import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/presentation/screens/main_screen_pages/shipping_page/bloc/shipping_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/cart/cart_item.dart';
import '../../../../data/models/product/product.dart';
import '../../../../data/models/user/user.dart';
import '../../../shared/utils.dart';
import 'bloc/cart_bloc.dart';
import 'bloc/cart_state.dart';

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
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
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
    final cartBloc = context.read<CartBloc>();
    final shippingBloc = context.read<ShippingBloc>();
    final listUsers = listCartItems.map((e) => e.user).toSet().toList();
    final Map<User?, List<CartItem>> map = {};
    for (final user in listUsers) {
      map[user] = listCartItems
          .where((element) => element.product?.userID == user?.id)
          .toList();
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: map.keys.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          map.keys.elementAt(index)?.avatarUrl != null
                              ? NetworkImage(
                                  map.keys.elementAt(index)?.avatarUrl ?? '')
                              : null),
                  const SizedBox(width: 16,),
                  Text(map.keys.elementAt(index)?.name ?? '')
                ]),
                const SizedBox(height: 16),
                ...map.values
                    .elementAt(index)
                    .map((e) => CartItemWidget(item: e)),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      cartBloc.add(
                          CartEventCreateOrderClicked(map.keys.elementAt(index)));
                      shippingBloc.add(ShippingEventCreateOrderClicked(
                          listCartItems,
                          map.keys.elementAt(index) ?? const User(),
                          map.values.elementAt(index).first.product?.userID ??
                              ''));
                    },
                    child: const Text('Place order'))
              ],
            ),
          );
        });
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final bloc = context.read<CartBloc>();
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: item.product?.pictureUrl != null
                  ? CachedNetworkImage(
                      imageUrl: item.product!.pictureUrl!,
                      height: 100,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
                          item.product ?? const Product(), locale, context)),
                  Expanded(
                      flex: 4,
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              bloc.add(CartEventRemoveFromCart(item.product!));
                            },
                            icon: const Icon(Icons.remove)),
                        Text(item.qty.toString()),
                        IconButton(
                            onPressed: () {
                              bloc.add(CartEventAddToCart(
                                  item.product!, item.user!));
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
                        _positionSumCalculationString(item, locale),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

String _positionSumCalculationString(CartItem item, Locale locale) {
  final formatCurrency = NumberFormat.simpleCurrency(locale: locale.toString());
  String price = item.product != null ? item.product!.price.toString() : '0';
  price = price + getCurrencySign(formatCurrency, locale);
  final qty = ' x ${item.qty}';
  String sum =
      ' = ${(item.product?.price != null) ? (item.product!.price! * item.qty) : 0}';
  sum = sum + getCurrencySign(formatCurrency, locale);
  return price + qty + sum;
}

Widget _productDescriptionBuilder(
    Product product, Locale locale, BuildContext context) {
  return Center(
      child: Column(children: [
    Text(product.name ?? '', style: Theme.of(context).textTheme.bodyText1)
  ]));
}
