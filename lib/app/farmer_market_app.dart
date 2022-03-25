import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../data/repository/auth_repository/auth_repository.dart';
import '../data/repository/cart_repository/cart_repository.dart';
import '../data/repository/order_repository/order_repository.dart';
import '../generated/l10n.dart';
import 'bloc/app_event.dart';
import 'bloc/app_state.dart';
import 'bloc/app_bloc.dart';
import 'di/getit_setup.dart';
import 'theme/theme_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FarmerMarketApp extends StatelessWidget {
  const FarmerMarketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          final authenticated = FirebaseAuth.instance.currentUser != null;
          final cartRepository = locator<CartRepository>();
          final orderRepository = locator<OrderRepository>();
          final authRepository = locator<AuthRepository>();

          return AppBloc(
              authenticated, cartRepository, orderRepository, authRepository)
            ..add(const AppEventAppLaunched());
        },
        child: const FarmerMarketAppBody());
  }
}

class FarmerMarketAppBody extends StatelessWidget {
  const FarmerMarketAppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        //print(state);
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
