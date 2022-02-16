import 'package:farmer_market/presentation/di/getit_setup.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_bloc.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_state.dart';
import 'package:farmer_market/repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/navigation_wrapper.dart';
import 'bloc/main_event.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
        create: (context) {
          return MainBloc(authRepository: locator.get<AuthRepository>())
            ..add(const MainScreenInit());
        },
        child: MainScreenBody());
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainBloc = context.read<MainBloc>();

    return BlocConsumer<MainBloc, MainState>(listener: (context, state) {
      if (state.mainScreenEditProfileClicked == true) {
        navigateToUserDetailScreen(context);
      }
    }, builder: (context, state) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                    backgroundImage: state.user?.avatarUrl == null
                        ? null
                        : NetworkImage(
                            state.user?.avatarUrl ?? 'https://gog.com')),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        mainBloc.add(const MainScreenEditProfileClicked());
                      },
                      child: Text(state.user?.name ?? '')),
                ))
              ],
            ),
          ),
          body: Container(
            child: Text(''),
          ),
        ),
      );
    });
  }
}
