
import 'package:flutter/material.dart';

import '../../navigation/navigation_wrapper.dart';

class MainScreenFab extends StatelessWidget {
  const MainScreenFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        navigateToAddProductScreen(context);
      },
      child: const Icon(Icons.add),
    );
  }
}
