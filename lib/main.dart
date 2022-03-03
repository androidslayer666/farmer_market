import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/di/getit_setup.dart';
import 'app/farmer_market_app.dart';



void main() async {
  // initialize binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // initialize firebase
  await Firebase.initializeApp();

  // initializing data layer dependencies
  setupGetIt();

  //FirebaseAuth.instance.signOut();
  // FlutterNativeSplash.remove();
  runApp(const FarmerMarketApp());
}
