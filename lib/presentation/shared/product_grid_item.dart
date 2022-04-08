import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/product/product.dart';
import '../navigation/arguments.dart';
import '../navigation/navigation_wrapper.dart';
import '../screens/main_screen/bloc/main_bloc.dart';
import '../screens/main_screen/bloc/main_event.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return GestureDetector(
      onTap: () {
        navigateToProductDetailScreen(context,
            arguments: ProductDetailArguments(product: product));
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Expanded(
              flex: 5,
              child: product.pictureUrl != null
                  ? CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      imageUrl: product.pictureUrl!)
                  : Image.asset('assets/images/placeholder-image.png')),
          Expanded(
              flex: 2,
              child: _productDescriptionBuilder(product, locale, context)),
        ]),
      ),
    );
  }
}

Widget _productDescriptionBuilder(
    Product product, Locale locale, BuildContext context) {
  final formatCurrency = NumberFormat.simpleCurrency(locale: locale.toString());
  String productName = reduceStringLengthTo(product.name, 15);
  // because of the ruble sign is not supported in intl 0.17.0 there is a custom function
  String price = reduceStringLengthTo(
          product.price != null ? product.price.toString() : '', 10) +
      (product.price != null ? getCurrencySign(formatCurrency, locale) : '');
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    Text(
  productName + ', ' + price,
  style: TextStyle(fontSize: 14, color: Theme.of(context).indicatorColor),
    ),
    if (product.address?.city != null)
  Text('${product.address?.city}',
      style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor))
  ]);
}
