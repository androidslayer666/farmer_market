import 'package:farmer_market/app/bloc/app_state.dart';
import 'package:farmer_market/data/repository/auth_repository/auth_repository.dart';
import 'package:farmer_market/data/repository/cart_repository/cart_repository.dart';
import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/filter/filter.dart';
import '../../../data/models/product/category.dart' as models;
import '../../../app/bloc/app_bloc.dart';
import '../../../app/di/getit_setup.dart';
import '../../../data/repository/product_repository/product_repository.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/app_bar.dart';
import '../bottom_bar_pages/cart_page/cart_page.dart';
import '../bottom_bar_pages/chat_page/chat_page.dart';
import '../bottom_bar_pages/list_products/list_products.dart';
import '../bottom_bar_pages/shipping_page/shipping_page.dart';
import '../bottom_bar_pages/user_products_page/user_products_page.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'bloc/main_state.dart';
import 'filter_widget.dart';

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
    const CartPage(),
    const ChatPage(),
    const ShippingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) =>
          BlocConsumer<MainBloc, MainState>(listener: (context, state) {
      }, builder: (context, mainState) {
        //control back button click behaviour
        final mainBloc = context.read<MainBloc>();
        final currentTab = mainState.pageStack[mainState.pageStack.length - 1];
        return WillPopScope(
          onWillPop: () => _mainScreenBackPressResolver(
              context: context,
              backButtonPressedWhenStackIsClear:
                  mainState.backButtonPressedWhenStackIsClear,
              mainBloc: mainBloc,
              stackIsNotEmpty: mainState.pageStack.length > 1),
          child: Scaffold(
              appBar: CustomAppBar(
                user: appState.currentUser,
                filterSwitchedOn: mainState.filterSwitchedOn,
                mainBloc: mainBloc,
                showFilter: currentTab == 0,
                onFilterClick: () async {
                  final filter = await navigateToFilterScreen(context, arguments: FilterArguments(filter: mainState.filter));
                  if(filter != null) {
                    mainBloc.add(MainScreenFilterChanged(filter));
                  }
                },
              ),
              body: Stack(children: [
                pages[currentTab],
                // if (mainState.filterSwitchedOn) MainScreenFilters(filter: mainState.filter)
              ]),
              floatingActionButton: mainState.pageStack.last == 1
                  ? FloatingActionButton(
                      backgroundColor: Theme.of(context).backgroundColor,
                      onPressed: () {
                        navigateToAddProductScreen(context);
                      },
                      child: const Icon(Icons.add),
                    )
                  : Container(),
              bottomNavigationBar: MainScreenButtonNavigationBar(
                mainBloc: mainBloc,
                currentTab: currentTab,
              )),
        );
      }),
    );
  }
}


Future<bool> _mainScreenBackPressResolver(
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

class MainScreenButtonNavigationBar extends StatelessWidget {
  const MainScreenButtonNavigationBar(
      {Key? key, required this.mainBloc, required this.currentTab})
      : super(key: key);

  final MainBloc mainBloc;
  final int currentTab;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            IconButton(
              enableFeedback: false,
              onPressed: () {
                mainBloc.add(const MainScreenTabChanged(3));
              },
              icon: Icon(
                currentTab == 3 ? Icons.chat_bubble : Icons.chat_bubble_outline,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                mainBloc.add(const MainScreenTabChanged(4));
              },
              icon: Icon(
                currentTab == 4
                    ? Icons.local_shipping
                    : Icons.local_shipping_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ));
  }
}
