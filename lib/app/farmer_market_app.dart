import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../generated/l10n.dart';
import 'bloc/app_state.dart';
import 'bloc/app_bloc.dart';
import 'theme/theme_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FarmerMarketApp extends StatelessWidget {
  const FarmerMarketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          // print(FirebaseAuth.instance.currentUser);
          final authenticated = FirebaseAuth.instance.currentUser != null;
          return AppBloc(authenticated);
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