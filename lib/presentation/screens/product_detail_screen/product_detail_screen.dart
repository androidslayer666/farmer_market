import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/data/repository/product_repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../app/bloc/app_state.dart';
import '../../../app/di/getit_setup.dart';
import '../../../data/models/product/product.dart';
import '../../../data/models/review/review.dart';
import '../../../data/models/user/user.dart';
import '../../../data/repository/user_repository/user_repository.dart';
import '../../navigation/arguments.dart';
import '../../shared/app_bar.dart';
import '../../shared/avatar_name_widget.dart';
import '../../shared/text_input_custom.dart';
import '../../shared/utils.dart';
import '../main_screen_pages/cart_page/bloc/cart_bloc.dart';
import '../main_screen_pages/cart_page/bloc/cart_state.dart';
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
                BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    builder: (context, productDetailState) =>
                        BlocListener<CartBloc, CartState>(
                          listener: (context, state) {
                            if (state.successfullyAddedToCart == true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Added to cart"),
                                duration: Duration(seconds: 1),
                              ));
                              if (state.successfullyAddedToCart == false) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Something went wrong when adding to cart"),
                                  duration: Duration(seconds: 1),
                                ));
                              }
                            }
                          },
                          child: ProductDetailScreenBody(
                              product: product,
                              appState: appState,
                              state: productDetailState),
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
    final productDetailBloc = context.read<ProductDetailBloc>();

    return Scaffold(
      appBar: CustomAppBar(user: appState.currentUser),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              state.product?.pictureUrl != null
                  ? CachedNetworkImage(imageUrl: state.product!.pictureUrl!)
                  : Image.asset('assets/images/placeholder-image.png'),
              ProductDetailProductDescription(product: state.product),

              ProductDetailUserAndCartRow(state: state),
              ProductDetailReviewBuilder(
                  listReview: state.product?.reviews ?? [],
                  productDetailBloc: productDetailBloc),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailUserAndCartRow extends StatelessWidget {
  const ProductDetailUserAndCartRow({Key? key, required this.state})
      : super(key: key);

  final ProductDetailState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarNameWidget(user: state.user),
          ProductDetailAddToCart(user: state.user, product: state.product)
        ],
      ),
    );
  }
}

class ProductDetailAddToCart extends StatelessWidget {
  const ProductDetailAddToCart({Key? key, this.user, this.product})
      : super(key: key);

  final Product? product;
  final User? user;

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    return OutlinedButton(
      style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all(Theme.of(context).backgroundColor)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.add, color: Theme.of(context).primaryColor),
        Icon(Icons.shopping_cart, color: Theme.of(context).primaryColor)
      ]),
      onPressed: () {
        cartBloc.add(CartEventAddToCart(product, user));
      },
    );
  }
}

class ProductDetailProductDescription extends StatelessWidget {
  const ProductDetailProductDescription({Key? key, required this.product})
      : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: locale.toString());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Column(children: [
        Text((product?.name ?? '') +
            ', ' +
            (product?.price ?? '').toString() +
            // because of the ruble sign is not supported in intl 0.17.0 there is a custom function
            getCurrencySign(formatCurrency, locale)),
        if (product?.address?.city != null) Text('${product?.address?.city}')
      ])),
    );
  }
}

class ProductDetailReviewBuilder extends StatefulWidget {
  const ProductDetailReviewBuilder(
      {Key? key, required this.listReview, required this.productDetailBloc})
      : super(key: key);

  final List<Review> listReview;
  final ProductDetailBloc productDetailBloc;

  @override
  State<ProductDetailReviewBuilder> createState() =>
      _ProductDetailReviewBuilderState();
}

class _ProductDetailReviewBuilderState
    extends State<ProductDetailReviewBuilder> {
  bool writeReview = false;
  bool showReviews = false;

  @override
  Widget build(BuildContext context) {
    final rating = getAverageRating(widget.listReview);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        children: [
          !writeReview
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: rating,
                            itemBuilder: (_, __) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            child: Text('Write review',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor)),
                            onTap: () {
                              writeReview = true;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                          onTap: () {
                            showReviews = !showReviews;
                            setState(() {});
                          },
                          child: Text('Show all reviews',
                              style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                  fontSize: 18)))
                    ],
                  ),
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
                        widget.productDetailBloc
                            .add(ProductDetailReviewRateChanged(rate: rate));
                      },
                    ),
                    Stack(children: [
                      TextInputCustom(
                        lines: null,
                        hint: 'Enter your review',
                        onChanged: (text) {
                          widget.productDetailBloc
                              .add(ProductDetailReviewTextChanged(text: text));
                        },
                      ),
                      Positioned(
                        right: 24,
                        child: GestureDetector(
                          onTap: () {
                            writeReview = !writeReview;
                            setState(() {});
                          },
                          child: Icon(Icons.close,
                              color: Theme.of(context).primaryColor),
                        ),
                      )
                    ]),
                    ElevatedButton(
                        onPressed: () {
                          widget.productDetailBloc
                              .add(const ProductDetailAddReviewClicked());
                        },
                        child: const Text('Add review'))
                  ],
                ),
          if (showReviews && widget.listReview.length > 10)
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: widget.listReview.length,
                  itemBuilder: (context, index) =>
                      ReviewItemBuilder(review: widget.listReview[index])),
            ),
          if (showReviews && widget.listReview.length <= 10)
            ...widget.listReview.map((e) => ReviewItemBuilder(review: e))
        ],
      ),
    );
  }
}

class ReviewItemBuilder extends StatelessWidget {
  const ReviewItemBuilder({Key? key, required this.review}) : super(key: key);

  final Review? review;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBarIndicator(
              itemSize: 16,
              rating: review?.rate ?? 0,
              itemBuilder: (_, __) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(review?.message ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
