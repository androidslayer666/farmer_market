import 'package:farmer_market/presentation/screens/filter_screen/filter_screen.dart';
import 'package:farmer_market/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:farmer_market/presentation/screens/user_detail_screen/user_detail_screen.dart';
import 'package:flutter/cupertino.dart';

import '../screens/add_product_screen/add_product_screen.dart';
import '../screens/chat_screen/chat_screen.dart';
import '../screens/edit_user_screen/edit_user_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/phone_enter_screen/phone_enter_screen.dart';

String signInRoute = '/signIn';
String mainRoute = '/main_screen';
String editUserRoute = '/editUser';
String addProductRoute = '/addProduct';
String productDetailRoute = '/productDetail';
String userDetailRoute = '/userDetail';
String chatRoute = '/chatScreen';
String filterRoute = '/filterScreen';

Map<String, Widget Function(BuildContext)> routes = {
  signInRoute: (context) => const PhoneEnterScreen(),
  mainRoute: (context) => const MainScreen(),
  editUserRoute: (context) => const EditUserScreen(),
  addProductRoute: (context) => const AddProductScreen(),
  productDetailRoute: (context) => const ProductDetailScreen(),
  userDetailRoute: (context) => const UserDetailScreen(),
  chatRoute: (context) => const ChatScreen(),
  filterRoute: (context) => const FilterScreen()
};
