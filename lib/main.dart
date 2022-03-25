import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/bloc/bloc_observer.dart';
import 'app/di/getit_setup.dart';
import 'app/farmer_market_app.dart';

void main() async {
  // initialize binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // initialize firebase
  await Firebase.initializeApp();

  // initializing data layer dependencies
  setupGetIt();

  //FirebaseAuth.instance.signOut();
  //FlutterNativeSplash.remove();
  BlocOverrides.runZoned(
        () {
          runApp( const FarmerMarketApp());
    },
    blocObserver: FarmerMarketBlocObserver() ,
  );
}



