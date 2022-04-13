import 'package:flutter/material.dart';

import '../../data/models/user/user.dart';
import '../navigation/arguments.dart';
import '../navigation/navigation_wrapper.dart';
import '../screens/main_screen/bloc/main_bloc.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.user,
      this.filterSwitchedOn = false,
      this.showFilter = false,
      this.mainBloc,
      this.onFilterClick})
      : super(key: key);

  final User? user;
  final bool filterSwitchedOn;
  final bool showFilter;
  final MainBloc? mainBloc;
  final Function? onFilterClick;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor, //change your color here
      ),
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0.8),
      title: GestureDetector(
        onTap: () {
          // navigate to account screen
          navigateToEditUserScreen(context,
              arguments: UserDetailArguments(user: widget.user));
        },
        child: Row(children: [
          CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: widget.user?.avatarUrl != null
                  ? NetworkImage(widget.user!.avatarUrl!)
                  : null),
        ]),
      ),
      actions: [
        if (widget.showFilter)
          IconButton(
              onPressed: () {
                if (widget.onFilterClick != null) widget.onFilterClick!();
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.filter_alt, size: 30),
              ),
              color: Theme.of(context).primaryColor)
      ],
    );
  }
}
