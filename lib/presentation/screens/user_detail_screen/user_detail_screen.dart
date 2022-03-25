import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer_market/data/repository/user_repository/user_repository.dart';
import 'package:farmer_market/presentation/screens/user_detail_screen/user_detail_cubit.dart';
import 'package:farmer_market/presentation/shared/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../app/bloc/app_state.dart';
import '../../../app/di/getit_setup.dart';
import '../../../data/repository/product_repository/product_repository.dart';
import '../../navigation/arguments.dart';
import '../../navigation/navigation_wrapper.dart';
import '../../shared/app_bar.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UserDetailArguments?;
    return BlocProvider<UserDetailCubit>(
        create: (context) {
          final _userRepository = locator<UserRepository>();
          final _productRepository = locator<ProductRepository>();
          return UserDetailCubit(_userRepository, _productRepository);
        },
        child: UserDetailScreenBody(args: args));
  }
}

class UserDetailScreenBody extends StatefulWidget {
  const UserDetailScreenBody({Key? key, this.args}) : super(key: key);

  final UserDetailArguments? args;

  @override
  State<UserDetailScreenBody> createState() => _UserDetailScreenBodyState();
}

class _UserDetailScreenBodyState extends State<UserDetailScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) =>
            BlocBuilder<UserDetailCubit, UserDetailState>(
                builder: (context, state) {
              return Scaffold(
                  appBar: CustomAppBar(user: appState.currentUser),
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            state.user?.avatarUrl != null
                                ? CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    imageUrl: state.user?.avatarUrl ?? '',
                                    height: 200,
                                    progressIndicatorBuilder: (_, __, ___) =>
                                        const CircularProgressIndicator(),
                                  )
                                : Image.asset(
                                    'assets/images/placeholder-image.png'),
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
            }));
  }

  @override
  void initState() {
    super.initState();
    final userDetailCubit = context.read<UserDetailCubit>();
    userDetailCubit.onInit(widget.args?.user?.id ?? '');
  }
}
