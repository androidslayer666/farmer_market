import 'package:farmer_market/presentation/screens/user_detal_screen/user_detal_screen.dart';
import 'package:flutter/cupertino.dart';

import '../screens/phone_enter_screen/phone_enter_screen.dart';
import '../screens/main/main_screen.dart';

String loginRoute = '/login';
String signInRoute = '/signIn';
String mainRoute = '/main';
String userDetailRoute = 'userDetail';

Map<String, Widget Function(BuildContext)> routes = {
  signInRoute: (context) => const PhoneEnterScreen(),
  mainRoute: (context) => const MainScreen(),
  userDetailRoute: (context) => const UserDetailScreen()
};
