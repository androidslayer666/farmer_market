import 'package:flutter/material.dart';

import '../../shared/gradient_mask.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';

class MainScreenBottomNavigationBar extends StatelessWidget {
  const MainScreenBottomNavigationBar(
      {Key? key,
      required this.mainBloc,
      required this.currentTab,
      required this.userIsSeller})
      : super(key: key);

  final MainBloc mainBloc;
  final int currentTab;
  final bool userIsSeller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.9),
            borderRadius:  const BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: BottomNavBarItem(
                  mainBloc: mainBloc,
                  currentTab: currentTab,
                  tabNumber: 0,
                  activeIcon: Icons.home,
                  nonActiveIcon: Icons.home_outlined,
                  text: 'Home',
                ),
              ),
              if (userIsSeller)
                Expanded(
                    flex: 1,
                    child: BottomNavBarItem(
                      mainBloc: mainBloc,
                      currentTab: currentTab,
                      tabNumber: 1,
                      activeIcon: Icons.work_outlined,
                      nonActiveIcon: Icons.work_outline_outlined,
                      text: 'My products',
                    )),
              Expanded(
                  flex: 1,
                  child: BottomNavBarItem(
                    mainBloc: mainBloc,
                    currentTab: currentTab,
                    tabNumber: userIsSeller ? 2 : 1,
                    activeIcon: Icons.shopping_cart,
                    nonActiveIcon: Icons.shopping_cart_outlined,
                    text: 'Cart',
                  )),
              Expanded(
                  flex: 1,
                  child: BottomNavBarItem(
                    mainBloc: mainBloc,
                    currentTab: currentTab,
                    tabNumber: userIsSeller ? 3 : 2,
                    activeIcon: Icons.message,
                    nonActiveIcon: Icons.message_outlined,
                    text: 'Chat',
                  )),
              Expanded(
                  flex: 1,
                  child: BottomNavBarItem(
                    mainBloc: mainBloc,
                    currentTab: currentTab,
                    tabNumber: userIsSeller ? 4 : 3,
                    activeIcon: Icons.local_shipping,
                    nonActiveIcon: Icons.local_shipping_outlined,
                    text: 'Orders',
                  )),
            ],
          )),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem(
      {Key? key,
      required this.mainBloc,
      required this.currentTab,
      required this.tabNumber,
      required this.activeIcon,
      required this.nonActiveIcon,
      required this.text})
      : super(key: key);

  final MainBloc mainBloc;
  final int currentTab;
  final int tabNumber;
  final IconData activeIcon;
  final IconData nonActiveIcon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          mainBloc.add(MainScreenTabChanged(tabNumber));
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: RadiantGradientMask(
                first: Colors.amber,
                //Theme.of(context).bottomAppBarColor,
                second: Colors.white,
                child: Icon(
                  currentTab == tabNumber ? activeIcon : nonActiveIcon,
                  color: Theme.of(context).bottomAppBarColor.withOpacity(0.9),
                  size: 30,
                ),
              ),
            ),
            Flexible(
                child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: Colors.brown),
            ))
          ],
        ));
  }
}
