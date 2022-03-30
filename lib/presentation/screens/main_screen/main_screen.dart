import 'package:farmer_market/app/bloc/app_state.dart';
import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../data/models/filter/filter.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/app_bar.dart';
import '../main_screen_pages/cart_page/cart_page.dart';
import '../main_screen_pages/chat_page/chat_page.dart';
import '../main_screen_pages/list_products/list_products_page.dart';
import '../main_screen_pages/shipping_page/shipping_page.dart';
import '../main_screen_pages/user_products_page/user_products_page.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'bloc/main_state.dart';
import 'main_screen_back_press_resolver.dart';
import 'main_screen_button_navigation_bar.dart';
import 'main_screen_fab.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      List<Widget> _pages = _getListPages(appState.currentUser?.isSeller == true);
      return BlocBuilder<MainBloc, MainState>(builder: (context, mainState) {
        return MainScreenBody(
          appState: appState,
          mainState: mainState,
          pages: _pages,
        );
      });
    });
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody(
      {Key? key,
      required this.mainState,
      required this.appState,
      required this.pages})
      : super(key: key);

  final MainState mainState;
  final AppState appState;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    final mainBloc = context.read<MainBloc>();
    final currentTab = mainState.pageStack[mainState.pageStack.length - 1];
    return WillPopScope(
      onWillPop: () => mainScreenBackPressResolver(
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
            onFilterClick: () {
              _getFilter(context, mainState.filter, mainBloc);
            },
          ),
          body: IndexedStack(
            index: currentTab,
            children: pages,
          ),
          floatingActionButton: mainState.pageStack.last == 1
              ? const MainScreenFab()
              : Container(),
          bottomNavigationBar: MainScreenButtonNavigationBar(
            mainBloc: mainBloc,
            currentTab: currentTab,
            userIsSeller: appState.currentUser?.isSeller == true,
          )),
    );
  }
}

void _getFilter(
    BuildContext context, Filter previousFilter, MainBloc mainBloc) async {
  final filter = await navigateToFilterScreen(context,
      arguments: FilterArguments(filter: previousFilter));
  if (filter != null) {
    mainBloc.add(MainScreenFilterChanged(filter));
  }
}

List<Widget> _getListPages(bool isSeller) {
  return isSeller
      ? [
          const ListProductsPage(),
          const UserProductsPage(),
          const CartPage(),
          const ChatPage(),
          const ShippingPage(),
        ]
      : [
          const ListProductsPage(),
          const CartPage(),
          const ChatPage(),
          const ShippingPage(),
        ];
}
