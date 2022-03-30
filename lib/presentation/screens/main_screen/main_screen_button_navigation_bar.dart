import 'package:flutter/material.dart';

import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';

class MainScreenButtonNavigationBar extends StatelessWidget {
  const MainScreenButtonNavigationBar(
      {Key? key, required this.mainBloc, required this.currentTab, required this.userIsSeller})
      : super(key: key);

  final MainBloc mainBloc;
  final int currentTab;
  final bool userIsSeller;

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
            if(userIsSeller)
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
                mainBloc.add(MainScreenTabChanged(userIsSeller? 2 : 1));
              },
              icon: Icon(
                currentTab == (userIsSeller? 2 : 1)
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                mainBloc.add(MainScreenTabChanged(userIsSeller? 3 : 2));
              },
              icon: Icon(
                currentTab == (userIsSeller? 3 : 2)? Icons.chat_bubble : Icons.chat_bubble_outline,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                mainBloc.add(MainScreenTabChanged(userIsSeller? 4 : 3));
              },
              icon: Icon(
                currentTab == (userIsSeller? 4 : 3)
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
