import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/app/bloc/app_event.dart';
import 'package:farmer_market/data/repository/product_repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../app/bloc/app_state.dart';
import '../../../app/di/getit_setup.dart';
import '../../../data/models/product/product.dart';
import '../../../data/models/review/review.dart';
import '../../../data/models/user/user.dart';
import '../../../data/repository/user_repository/user_repository.dart';
import '../../navigation/arguments.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/app_bar.dart';
import '../../shared/utils.dart';
import '../main_screen/bloc/main_state.dart';
import '../main_screen_pages/cart_page/bloc/cart_bloc.dart';
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
          return ProductDetailBloc(const ProductDetailState(),
              locator<UserRepository>(), locator<ProductRepository>())
            ..add(ProductDetailOnInit(product));
        },
        child: BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) =>
                BlocConsumer<ProductDetailBloc, ProductDetailState>(
                    listener: (context, state) {},
                    builder: (context, state) => ProductDetailScreenBody(
                          product: product,
                          appState: appState,
                          state: state,
                        ))));
  }
}

class ProductDetailScreenBody extends StatelessWidget {
  const ProductDetailScreenBody(
      {Key? key, this.product, required this.state, required this.appState})
      : super(key: key);
  final ProductDetailState state;
  final Product? product;
  final AppState appState;

  @override
  Widget build(BuildContext context) {

    final cartBloc = context.read<CartBloc>();
    final productDetailBloc = context.read<ProductDetailBloc>();
    final locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: CustomAppBar(user: appState.currentUser),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              state.product?.pictureUrl != null
                  ? CachedNetworkImage(imageUrl: state.product!.pictureUrl!)
                  : Image.asset('assets/images/placeholder-image.png'),
              _productDescriptionBuilder(state.product, locale),
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
                        )),
                  ),
                ]),
              ),
              const Divider(height: 50),
              ProductDetailReviewBuilder(
                  showReview: state.showReview,
                  listReview: state.product?.reviews ?? [],
                  productDetailBloc: productDetailBloc),
              const Divider(height: 50),
              OutlinedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).backgroundColor)),
                child:

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      Icon(Icons.shopping_cart)
                    ]),
                onPressed: () {
                  cartBloc.add(CartEventAddToCart(
                      product ?? const Product(), state.user ?? const User()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailReviewBuilder extends StatelessWidget {
  const ProductDetailReviewBuilder(
      {Key? key,
      required this.showReview,
      required this.listReview,
      required this.productDetailBloc})
      : super(key: key);

  final bool showReview;
  final List<Review> listReview;
  final ProductDetailBloc productDetailBloc;

  @override
  Widget build(BuildContext context) {
    //print(listReview);
    final rating = getAverageRating(listReview);
    print(rating);
    return !showReview
        ? Row(
            children: [
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (_, __) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              GestureDetector(
                child: const Text('Write review'),
                onTap: () {
                  productDetailBloc.add(const ProductDetailToggleReview());
                },
              ),
            ],
          )
        : Column(
            children: [
              RatingBar.builder(
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rate) {
                  productDetailBloc
                      .add(ProductDetailReviewRateChanged(rate: rate));
                },
              ),
              TextField(
                onChanged: (text) {
                  productDetailBloc
                      .add(ProductDetailReviewTextChanged(text: text));
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    productDetailBloc
                        .add(const ProductDetailAddReviewClicked());
                  },
                  child: const Text('Add review'))
            ],
          );
  }
}

Widget _productDescriptionBuilder(Product? product, Locale locale) {
  final formatCurrency = NumberFormat.simpleCurrency(locale: locale.toString());
  return Center(
      child: Column(children: [
    Text((product?.name ?? '') +
        ', ' +
          (product?.price ?? '').toString() +
        // because of the ruble sign is not supported in intl 0.17.0 there is a custom function
        getCurrencySign(formatCurrency, locale)),
    if (product?.address?.city != null) Text('${product?.address?.city}')
  ]));
}
