import 'package:farmer_market/presentation/screens/user_detail_screen/user_detal_screen.dart';
import 'package:flutter/cupertino.dart';

import '../screens/add_product/add_product_screen.dart';
import '../screens/phone_enter_screen/phone_enter_screen.dart';
import '../screens/main/main_screen.dart';

String signInRoute = '/signIn';
String mainRoute = '/main';
String userDetailRoute = 'userDetail';
String addProductRoute = 'addProduct';

Map<String, Widget Function(BuildContext)> routes = {
  signInRoute: (context) => const PhoneEnterScreen(),
  mainRoute: (context) => const MainScreen(),
  userDetailRoute: (context) => const UserDetailScreen(),
  addProductRoute: (context) => const AddProductScreen()
};
