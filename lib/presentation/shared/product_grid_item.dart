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
    final mainBloc = context.read<MainBloc>();
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
                  ? CachedNetworkImage(imageUrl: product.pictureUrl!)
                  : Image.asset('assets/images/placeholder-image.png')),
          Expanded(flex: 2, child: _productDescriptionBuilder(product, locale)),
        ]),
      ),
    );
  }
}

Widget _productDescriptionBuilder(Product product, Locale locale) {
  final formatCurrency = NumberFormat.simpleCurrency(locale: locale.toString());
  return Center(
      child: Wrap(children: [
    Text((product.name ?? '') +
        ', ' +
        product.price.toString() +
        // because of the ruble sign is not supported in intl 0.17.0 there is a custom function
        getCurrencySign(formatCurrency, locale)),
    if (product.address?.city != null) Text('${product.address?.city}')
  ]));
}
