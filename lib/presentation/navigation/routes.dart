import 'package:flutter/cupertino.dart';

import '../screens/login/login_screen.dart';
import '../screens/signin_screen/signin_screen.dart';
import '../screens/main/main_screen.dart';

String loginRoute = '/login';
String signInRoute = '/signIn';
String mainRoute = '/main';

Map<String, Widget Function(BuildContext)> routes = {
  loginRoute: (context) => const LoginScreen(),
  signInRoute: (context) => const SignInScreen(),
  mainRoute: (context) => const MainScreen(),
};
