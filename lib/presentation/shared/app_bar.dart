import 'package:flutter/material.dart';

import '../../data/models/user/user.dart';
import '../navigation/arguments.dart';
import '../navigation/navigation_wrapper.dart';
import '../screens/main_screen/bloc/main_bloc.dart';
import '../screens/main_screen/bloc/main_event.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.user,
      this.filterSwitchedOn = false,
      this.showFilter = false,
      this.mainBloc,
      this.onFilterClick
      })
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
      backgroundColor: Theme.of(context).backgroundColor,
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
          Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.user?.name ?? '',
                  style: const TextStyle(color: Colors.white),
                )),
          )
        ]),
      ),
      actions: [
        if(widget.showFilter)
          IconButton(onPressed: (){
          if(widget.onFilterClick !=null) widget.onFilterClick!();
          // widget.mainBloc?.add(const MainScreenFilterToggled());
        }, icon: Icon(
              widget.filterSwitchedOn ?
              Icons.filter_alt
          : Icons.filter_alt_outlined))
      ],
    );
  }
}
