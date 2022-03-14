import 'package:farmer_market/data/repository/auth_repository/auth_repository.dart';
import 'package:farmer_market/data/repository/cart_repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/getit_setup.dart';
import '../../../data/repository/products/product_repository.dart';
import '../../navigation/arguments.dart';
import '../../navigation/navigation_wrapper.dart';
import '../bottom_bar_pages/cart_page/cart_page.dart';
import '../bottom_bar_pages/list_products/list_products.dart';
import '../bottom_bar_pages/user_products_page/user_products_page.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'bloc/main_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bloc = MainBloc(
      authRepository: locator.get<AuthRepository>(),
      productRepository: locator.get<ProductRepository>(),
      cartRepository: locator<CartRepository>())
    ..add(const MainScreenInit());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
        create: (context) {
          return bloc;
        },
        child: const MainScreenBody());
  }
}

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  final pages = [
    const ListProductsPage(),
    const UserProductsPage(),
    const CartPage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(listener: (context, state) {
      // print(state.cart.cartItems);
    }, builder: (context, state) {
      //control back button click behaviour
      final mainBloc = context.read<MainBloc>();
      final currentTab = state.pageStack[state.pageStack.length - 1];
      return WillPopScope(
        onWillPop: () async {
          if (state.pageStack.length > 1) {
            mainBloc.add(const MainScreenBackButtonPressed());
          } else {
            mainBloc.add(const MainScreenBackButtonPressedWhenStackIsClear());
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Click back one more time to close the app')));
          }
          if (state.backButtonPressedWhenStackIsClear == true) {
            return true;
          }
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: GestureDetector(
              onTap: () {
                // navigate to account screen
                navigateToUserDetailScreen(context,
                    arguments: UserDetailArguments(user: state.user));
              },
              child: Row(children: [
                CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: state.user?.avatarUrl != null
                        ? NetworkImage(state.user!.avatarUrl!)
                        : null),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.user?.name ?? '',
                        style: const TextStyle(color: Colors.white),
                      )),
                )
              ]),
            ),
          ),
          body: pages[currentTab],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).backgroundColor,
            onPressed: () {
              navigateToAddProductScreen(context);
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      mainBloc.add(const MainScreenTabChanged(0));
                    },
                    icon: Icon(
                      currentTab == 0 ? Icons.list_alt_sharp : Icons.list,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      mainBloc.add(const MainScreenTabChanged(1));
                    },
                    icon: Icon(
                      currentTab == 1
                          ? Icons.work_outlined
                          : Icons.work_outline_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      mainBloc.add(const MainScreenTabChanged(2));
                    },
                    icon: Icon(
                      currentTab == 2
                          ? Icons.shopping_cart
                          : Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }
}
