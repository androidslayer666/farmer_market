import 'package:farmer_market/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:farmer_market/presentation/screens/user_detail_screen/user_detal_screen.dart';
import 'package:flutter/cupertino.dart';

import '../screens/add_product/add_product_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/phone_enter_screen/phone_enter_screen.dart';

String signInRoute = '/signIn';
String mainRoute = '/main_screen';
String userDetailRoute = '/userDetail';
String addProductRoute = '/addProduct';
String productDetailRoute = '/productDetail';

Map<String, Widget Function(BuildContext)> routes = {
  signInRoute: (context) => const PhoneEnterScreen(),
  mainRoute: (context) => const MainScreen(),
  userDetailRoute: (context) => const UserDetailScreen(),
  addProductRoute: (context) => const AddProductScreen(),
  productDetailRoute: (context) => const ProductDetailScreen()
};
