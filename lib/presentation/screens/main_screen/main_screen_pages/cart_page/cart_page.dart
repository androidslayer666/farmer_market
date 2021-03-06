import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/cart/cart_item.dart';
import '../../../../../data/models/product/product.dart';
import '../../../../../data/models/user/user.dart';
import '../../../../navigation/navigation_wrapper.dart';
import '../../../../shared/avatar_name_widget.dart';
import '../../../../shared/utils.dart';
import '../../main_screen_pages/shipping_page/bloc/shipping_bloc.dart';
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
          mapUserToItems: state.mapUserToItems,
          listCartItems: state.cart.cartItems,
        )
      ]);
    });
  }
}

class CartList extends StatelessWidget {
  const CartList(
      {Key? key, required this.listCartItems, required this.mapUserToItems})
      : super(key: key);

  final List<CartItem> listCartItems;
  final Map<User?, List<CartItem>>? mapUserToItems;

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    final shippingBloc = context.read<ShippingBloc>();
    if (listCartItems.isEmpty == true) {
      return SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text('There are no items in your cart',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500)),
        ),
      ));
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: mapUserToItems?.keys.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                AvatarNameWidget(
                  user: mapUserToItems?.keys.elementAt(index),
                ),
                const SizedBox(height: 16),
                ...?mapUserToItems?.values
                    .elementAt(index)
                    .map((e) => CartItemWidget(item: e)),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      cartBloc.add(CartEventCreateOrderClicked(
                          mapUserToItems?.keys.elementAt(index)));
                      shippingBloc.add(ShippingEventCreateOrderClicked(
                          listCartItems,
                          mapUserToItems?.keys.elementAt(index) ?? const User(),
                          mapUserToItems?.values
                                  .elementAt(index)
                                  .first
                                  .product
                                  ?.userID ??
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
              child: GestureDetector(
                onTap: () => navigateToProductDetailScreen(context,
                    arguments: ProductDetailArguments(product: item.product)),
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
                    : Image.asset('assets/images/placeholder-image.png'),
              )),
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
                            icon: Icon(
                              Icons.remove,
                              color: Theme.of(context).primaryColor,
                            )),
                        Text(item.qty.toString()),
                        IconButton(
                            onPressed: () {
                              bloc.add(CartEventAddToCart(
                                  item.product!, item.user!));
                            },
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).bottomAppBarColor,
                            )),
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
