import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:flutter/cupertino.dart';

import 'arguments.dart';

void navigateToMainScreen(BuildContext context, {bool clearStack = false}) {
  print('navigateToMainScreen');
  if (clearStack) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(mainRoute, (Route<dynamic> route) => false);
  } else {
    Navigator.of(context).pushNamed(mainRoute);
  }
}

void navigateToUserDetailScreen(BuildContext context,
    {bool clearStack = false, UserDetailArguments? arguments}) {
  print('navigateToUserDetailScreen');
  if (clearStack) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        userDetailRoute, (Route<dynamic> route) => false);
  } else {
    Navigator.of(context).pushNamed(userDetailRoute, arguments: arguments);
  }
}

void navigateToEnterPhoneScreen(BuildContext context,
    {bool clearStack = false}) {
  print('navigateToEnterPhoneScreen');
  if (clearStack) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(signInRoute, (Route<dynamic> route) => false);
  } else {
    Navigator.of(context).pushNamed(signInRoute);
  }
}

void navigateToAddProductScreen(BuildContext context,
    {AddProductArguments? arguments}) {
  print('navigateToAddProductScreen');
  Navigator.of(context).pushNamed(addProductRoute, arguments: arguments);
}

void navigateToProductDetailScreen(BuildContext context,
    {ProductDetailArguments? arguments}) {
  print('navigateToAddProductScreen');
  Navigator.of(context).pushNamed(productDetailRoute, arguments: arguments);
}
