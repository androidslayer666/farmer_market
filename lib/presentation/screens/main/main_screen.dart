import 'package:farmer_market/presentation/screens/main/bloc/main_bloc.dart';
import 'package:farmer_market/presentation/screens/main/bloc/main_state.dart';
import 'package:farmer_market/repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/main_event.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (context) {
        return MainBloc(authRepository: AuthRepository())
          ..add(const MainScreenInit());
      },
      child: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        return Scaffold(
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
                  child: Text(state.user?.name ?? ''),
                ))
              ],
            ),
          ),
          body: Container(
            child: Text(''),
          ),
        );
      }),
    );
  }
}
