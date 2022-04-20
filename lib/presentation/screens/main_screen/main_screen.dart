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
import '../main_screen_pages/list_products/bloc/list_product_bloc.dart';
import '../main_screen_pages/list_products/bloc/list_product_state.dart';
import '../main_screen_pages/list_products/list_products_page.dart';
import '../main_screen_pages/shipping_page/shipping_page.dart';
import '../main_screen_pages/user_products_page/user_products_page.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_state.dart';
import 'main_screen_back_press_resolver.dart';
import 'main_screen_bottom_navigation_bar.dart';
import 'main_screen_fab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final List<Widget> _pages;

  @override
  void initState() {
    _pages = _getListPages(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      return BlocBuilder<ListProductBloc, ListProductState>(
        builder: (context, listProductState) {
          return BlocBuilder<MainBloc, MainState>(
              builder: (context, mainState) {
            return MainScreenBody(
              appState: appState,
              listProductState: listProductState,
              mainState: mainState,
              pages: _pages,
            );
          });
        },
      );
    });
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody(
      {Key? key,
      required this.mainState,
      required this.appState,
      required this.pages,
      required this.listProductState})
      : super(key: key);

  final MainState mainState;
  final ListProductState listProductState;
  final AppState appState;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    final listProductBloc = context.read<ListProductBloc>();
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
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: CustomAppBar(
            user: appState.currentUser,
            filterSwitchedOn: mainState.filterSwitchedOn,
            mainBloc: mainBloc,
            showFilter: currentTab == 0,
            onFilterClick: () {
              _getFilter(context, listProductState.filter, listProductBloc);
            },
          ),
          body: IndexedStack(
            index: currentTab,
            children: pages,
          ),
          floatingActionButton: mainState.pageStack.last == 1
              ? const MainScreenFab()
              : Container(),
          bottomNavigationBar: MainScreenBottomNavigationBar(
            mainBloc: mainBloc,
            currentTab: currentTab,
            userIsSeller: appState.currentUser?.isSeller == true,
          )),
    );
  }
}

void _getFilter(BuildContext context, Filter? previousFilter,
    ListProductBloc listProductBloc) async {
  final filter = await navigateToFilterScreen(context,
      arguments: FilterArguments(filter: previousFilter));
  if (filter != null) {
    listProductBloc.add(ListProductFilterChanged(filter));
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
