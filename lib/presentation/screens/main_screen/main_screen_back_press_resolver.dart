
import 'package:flutter/material.dart';

import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';

Future<bool> mainScreenBackPressResolver(
    {required bool stackIsNotEmpty,
      required MainBloc mainBloc,
      required BuildContext context,
      required bool? backButtonPressedWhenStackIsClear}) async {
  if (stackIsNotEmpty) {
    mainBloc.add(const MainScreenBackButtonPressed());
  } else {
    mainBloc.add(const MainScreenBackButtonPressedWhenStackIsClear());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Click back one more time to close the app')));
  }
  if (backButtonPressedWhenStackIsClear == true) {
    return true;
  }
  return false;
}
