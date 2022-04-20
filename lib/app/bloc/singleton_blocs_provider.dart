

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository/auth_repository.dart';
import '../../data/repository/cart_repository/cart_repository.dart';
import '../../data/repository/order_repository/order_repository.dart';
import '../../data/repository/product_repository/product_repository.dart';
import '../../presentation/screens/main_screen/bloc/main_bloc.dart';
import '../../presentation/screens/main_screen/bloc/main_event.dart';
import '../../presentation/screens/main_screen_pages/cart_page/bloc/cart_bloc.dart';
import '../../presentation/screens/main_screen_pages/list_products/bloc/list_product_bloc.dart';
import '../../presentation/screens/main_screen_pages/shipping_page/bloc/shipping_bloc.dart';
import '../../presentation/screens/main_screen_pages/user_products_page/bloc/user_products_bloc.dart';
import '../di/getit_setup.dart';
import 'app_bloc.dart';
import 'app_event.dart';



class SingletonBlocsProvider extends StatelessWidget {
  const SingletonBlocsProvider({Key? key, required this.child}) : super(key: key);

  final Widget child;



  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc(
        FirebaseAuth.instance.currentUser != null,
        locator<CartRepository>(),
        locator<OrderRepository>(),
        locator<AuthRepository>());

    final mainBloc = MainBloc();

    final listProductBloc =
    ListProductBloc(productRepository: locator.get<ProductRepository>());

    final shippingBloc = ShippingBloc(
        authRepository: locator.get<AuthRepository>(),
        orderRepository: locator<OrderRepository>(),
        cartRepository: locator<CartRepository>());

    final cartBloc = CartBloc(locator<CartRepository>());

    final userProductsBloc = UserProductsBloc(
        productRepository: locator.get<ProductRepository>(),
        authRepository: locator.get<AuthRepository>());

    return MultiBlocProvider(providers: [
      BlocProvider<AppBloc>(
          create: (context) => appBloc..add(const AppEventAppLaunched())),
      BlocProvider<ListProductBloc>(
          create: (context) =>
          listProductBloc..add(const ListProductEventPageRequested())),
      BlocProvider<MainBloc>(
          create: (context) => mainBloc..add(const MainScreenInit())),
      BlocProvider<ShippingBloc>(
          create: (context) => shippingBloc..add(const ShippingEventInit())),
      BlocProvider<CartBloc>(
          create: (context) => cartBloc..add(const CartEventInit())),
      BlocProvider<UserProductsBloc>(
          create: (context) => userProductsBloc..add(const UserProductsEventInit()))
    ], child: child);
  }
}


