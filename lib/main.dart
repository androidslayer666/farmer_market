import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'farmer_market_app.dart';
import 'presentation/di/getit_setup.dart';

void main() async {

  // initialize binding
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp();

  // initializing data layer dependencies
  setupGetIt();

  FirebaseAuth.instance.signOut();

  //checking authorization
  final page = await _getInitPage();

  runApp( FarmerMarketApp(initialPage: page));
}

Future<String> _getInitPage() async {
  final isAuthorized = FirebaseAuth.instance.currentUser;
  if(isAuthorized != null) {
    return mainRoute;
  }
  return loginRoute;
}
