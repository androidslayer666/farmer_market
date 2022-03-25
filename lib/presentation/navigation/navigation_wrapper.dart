import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/filter/filter.dart';
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

void navigateToEditUserScreen(BuildContext context,
    {bool clearStack = false, UserDetailArguments? arguments}) {
  print('navigateToUserDetailScreen');
  if (clearStack) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        editUserRoute, (Route<dynamic> route) => false);
  } else {
    Navigator.of(context).pushNamed(editUserRoute, arguments: arguments);
  }
}

void navigateToUserDetailScreen(BuildContext context,
    {required UserDetailArguments? arguments}) {
  print('navigateToUserDetailScreen');
  Navigator.of(context).pushNamed(userDetailRoute, arguments: arguments);
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
  print('navigateToProductDetailScreen');
  Navigator.of(context).pushNamed(productDetailRoute, arguments: arguments);
}

void navigateToChatScreen(BuildContext context,
    {required UserDetailArguments? arguments}) {
  print('navigateToChatScreen');
  Navigator.of(context).pushNamed(chatRoute, arguments: arguments);
}

Future<Filter?> navigateToFilterScreen(
    BuildContext context,
    {required FilterArguments? arguments}
) async {
  print('navigateToFilterScreen');
  final filter = await Navigator.of(context).pushNamed(filterRoute, arguments: arguments);
  if(filter is Filter) {
    return filter;
  }
  return null;
}