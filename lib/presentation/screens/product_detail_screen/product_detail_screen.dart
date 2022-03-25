import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/app/bloc/app_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../app/bloc/app_state.dart';
import '../../../app/di/getit_setup.dart';
import '../../../data/models/product/product.dart';
import '../../../data/models/user/user.dart';
import '../../../data/repository/user_repository/user_repository.dart';
import '../../navigation/arguments.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/app_bar.dart';
import '../../shared/utils.dart';
import '../main_screen/bloc/main_bloc.dart';
import '../main_screen/bloc/main_event.dart';
import 'bloc/product_detail_screen_bloc.dart';
import 'bloc/product_detail_screen_event.dart';
import 'bloc/product_detail_screen_state.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product? product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product =
        (ModalRoute.of(context)!.settings.arguments as ProductDetailArguments?)
            ?.product;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return ProductDetailScreenBloc(
              const ProductDetailScreenState(), locator<UserRepository>())
            ..add(ProductDetailScreenOnInit(product?.userID ?? ''));
        },
        child: ProductDetailScreenBody(product: product));
  }
}

class ProductDetailScreenBody extends StatefulWidget {
  const ProductDetailScreenBody({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  State<ProductDetailScreenBody> createState() =>
      _ProductDetailScreenBodyState();
}

class _ProductDetailScreenBodyState extends State<ProductDetailScreenBody> {
  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final locale = Localizations.localeOf(context);
    return BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) => BlocConsumer<ProductDetailScreenBloc, ProductDetailScreenState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Scaffold(
          appBar: CustomAppBar(user: appState.currentUser),
          body: Column(
            children: [
              widget.product?.pictureUrl != null
                  ? CachedNetworkImage(imageUrl: widget.product!.pictureUrl!)
                  : Image.asset('assets/images/placeholder-image.png'),
              _productDescriptionBuilder(widget.product!, locale),
              GestureDetector(
                onTap: () {
                  // navigate to account screen

                  navigateToUserDetailScreen(context,
                      arguments: UserDetailArguments(user: state.user));
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
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).backgroundColor)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add),
                          Icon(Icons.shopping_cart)
                        ]),
                    onPressed: () {
                      appBloc.add(AppStateAddToCart(
                          widget.product ?? const Product(),
                          state.user ?? const User()));
                    },
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    ));
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
    if (product.address?.city != null) Text('${product.address?.city}')
  ]));
}