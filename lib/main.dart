import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/di/getit_setup.dart';
import 'app/farmer_market_app.dart';

void main() async {

  // initialize binding
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp();

  // initializing data layer dependencies
  setupGetIt();

  //FirebaseAuth.instance.signOut();

  runApp( const FarmerMarketApp());
}
