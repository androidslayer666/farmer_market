import 'package:farmer_market/presentation/navigation/routes.dart';
import 'package:flutter/cupertino.dart';

void navigateToMainScreen(BuildContext context, {bool clearStack = false}) {
  print('navigateToMainScreen');
  if(clearStack){
    Navigator.of(context).pushNamedAndRemoveUntil(mainRoute, (Route<dynamic> route) => false);
  }else {
    Navigator.of(context).pushNamed(mainRoute);
  }
}

void navigateToUserDetailScreen(BuildContext context, {bool clearStack = false}){
  print('navigateToUserDetailScreen');
  if(clearStack){
    Navigator.of(context).pushNamedAndRemoveUntil(userDetailRoute, (Route<dynamic> route) => false);
  }else {
    Navigator.of(context).pushNamed(userDetailRoute);
  }
}


void navigateToEnterPhoneScreen(BuildContext context, {bool clearStack = false}){
  print('navigateToEnterPhoneScreen');
  if(clearStack){
    Navigator.of(context).pushNamedAndRemoveUntil(signInRoute, (Route<dynamic> route) => false);
  }else {
    Navigator.of(context).pushNamed(signInRoute);
  }
}
