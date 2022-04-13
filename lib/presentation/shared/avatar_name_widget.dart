import 'package:flutter/material.dart';

import '../../data/models/user/user.dart';
import '../navigation/arguments.dart';
import '../navigation/navigation_wrapper.dart';

class AvatarNameWidget extends StatelessWidget {
  const AvatarNameWidget(
      {Key? key, required this.user, this.onClickNavigate = true})
      : super(key: key);

  final User? user;
  final bool onClickNavigate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClickNavigate) {
          navigateToUserDetailScreen(context,
              arguments: UserDetailArguments(user: user));
        }
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: user?.avatarUrl != null
                ? NetworkImage(user!.avatarUrl!)
                : null),
        Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                user?.name ?? '',
              )),
        ),
      ]),
    );
  }
}
