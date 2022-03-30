import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../data/repository/auth_repository/auth_repository.dart';
import '../data/repository/cart_repository/cart_repository.dart';
import '../data/repository/order_repository/order_repository.dart';
import '../data/repository/product_repository/product_repository.dart';
import '../generated/l10n.dart';
import '../presentation/screens/main_screen/bloc/main_bloc.dart';
import '../presentation/screens/main_screen/bloc/main_event.dart';
import '../presentation/screens/main_screen_pages/cart_page/bloc/cart_bloc.dart';
import '../presentation/screens/main_screen_pages/list_products/bloc/list_product_bloc.dart';
import '../presentation/screens/main_screen_pages/shipping_page/bloc/shipping_bloc.dart';
import 'bloc/app_bloc.dart';
import 'bloc/app_event.dart';
import 'bloc/app_state.dart';
import 'di/getit_setup.dart';
import 'theme/theme_data.dart';

class FarmerMarketApp extends StatelessWidget {
  const FarmerMarketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc(
        FirebaseAuth.instance.currentUser != null,
        locator<CartRepository>(),
        locator<OrderRepository>(),
        locator<AuthRepository>());

    final mainBloc = MainBloc(
        authRepository: locator.get<AuthRepository>(),
        productRepository: locator.get<ProductRepository>());

    final listProductBloc =
        ListProductBloc(productRepository: locator.get<ProductRepository>());

    final shippingBloc = ShippingBloc(
        authRepository: locator.get<AuthRepository>(),
        orderRepository: locator<OrderRepository>(),
        cartRepository: locator<CartRepository>());

    final cartBloc = CartBloc(locator<CartRepository>());

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
          create: (context) => cartBloc..add(const CartEventInit()))
    ], child: const FarmerMarketAppBody());
  }
}

class FarmerMarketAppBody extends StatelessWidget {
  const FarmerMarketAppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return MaterialApp(
          theme: themeData,
          initialRoute: state.authenticated ? mainRoute : signInRoute,
          routes: routes,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
