import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/data/repository/user_repository/user_repository.dart';
import 'package:farmer_market/presentation/screens/user_detail_screen/user_detail_cubit.dart';
import 'package:farmer_market/presentation/shared/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../app/bloc/app_state.dart';
import '../../../app/di/getit_setup.dart';
import '../../../data/models/user/user.dart';
import '../../../data/repository/product_repository/product_repository.dart';
import '../../navigation/arguments.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/app_bar.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
    (ModalRoute.of(context)!.settings.arguments as UserDetailArguments?)?.user;
    return BlocProvider<UserDetailCubit>(
        create: (context) {
          final _userRepository = locator<UserRepository>();
          final _productRepository = locator<ProductRepository>();
          return UserDetailCubit(_userRepository, _productRepository)..onInit(user?.id);
        },
        child: BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) =>
                BlocBuilder<UserDetailCubit, UserDetailState>(
                    builder: (context, state) {
                  return UserDetailScreenBody(
                      user: user, appState: appState, state: state);
                })));
  }
}

class UserDetailScreenBody extends StatelessWidget {
  const UserDetailScreenBody(
      {Key? key, this.user, required this.state, required this.appState})
      : super(key: key);

  final User? user;
  final UserDetailState state;
  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(user: appState.currentUser),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  UserDetailAvatar(
                    user: state.user,
                  ),
                  Text(state.user?.name ?? ''),
                  ElevatedButton(
                      onPressed: () {
                        navigateToChatScreen(context,
                            arguments: UserDetailArguments(
                                user: appState.currentUser));
                      },
                      child: const Text('Message')),
                  ...?state.listProducts
                      ?.map((e) => ProductListItem(product: e))
                ],
              ),
            ),
          ),
        ));
  }
}

class UserDetailAvatar extends StatelessWidget {
  const UserDetailAvatar({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return user?.avatarUrl != null
        ? CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      imageUrl: user?.avatarUrl ?? '',
      height: 200
    )
        : Image.asset('assets/images/placeholder-image.png');
  }
}
