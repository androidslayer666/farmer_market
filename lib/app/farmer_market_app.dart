import 'package:farmer_market/app/app_bloc.dart';
import 'package:farmer_market/app/app_state.dart';
import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmerMarketApp extends StatelessWidget {
  final String? initialPage;

  const FarmerMarketApp({Key? key, this.initialPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<User?> authStream = FirebaseAuth.instance.authStateChanges();
    return BlocProvider(
        create: (context) {
          return AppBloc(authStream);
        },
        child: BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state.authenticationStatus ==
                AuthenticationStatus.authenticated) {
              print("SUCCESSFUL LOGIN!!!!");
              //Navigator.of(context).pushNamed(mainRoute);
            }
          },
          child: MaterialApp(
            initialRoute: initialPage,
            routes: routes,
          ),
        ));
  }
}
