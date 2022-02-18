import 'package:farmer_market/app/bloc/app_bloc.dart';
import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_state.dart';
import 'bloc/app_bloc.dart';
import 'theme/theme_data.dart';

class FarmerMarketApp extends StatelessWidget {
  const FarmerMarketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          print(FirebaseAuth.instance.currentUser);
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
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        print(state);
        return MaterialApp(
          key: UniqueKey(),
          theme: themeData,
          initialRoute: state.authenticated ? mainRoute : signInRoute,
          routes: routes,
        );
      },
    );
  }
}
