import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/auth_repository/auth_repository.dart';
import '../../di/getit_setup.dart';
import '../../shared/text_input_custom.dart';
import 'bloc/user_detal_bloc.dart';
import 'bloc/user_detal_event.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
        ),
        body: BlocProvider(
          create: (context) {
            return UserDetailBloc(authRepository: locator<AuthRepository>(), context: context);
          },
          child: UserDetailScreenBody(),
        ));
  }
}

class UserDetailScreenBody extends StatelessWidget {
  UserDetailScreenBody({Key? key}) : super(key: key);

  //final loginController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    final signInBloc = context.read<UserDetailBloc>();
    return Column(children: [
      TextInputCustom(
        controller: TextEditingController(text: 'oleg'),
        hint: 'Name',
        onChanged: (value) {
          signInBloc.add(UserDetailNameChanged(value));
        },
      ),
      TextInputCustom(
        controller: TextEditingController(text: '+79200657986'),
        hint: 'Phone',
        onChanged: (value) {
          signInBloc.add(UserDetailPhoneChanged(value));
        },
      ),
      TextInputCustom(
        controller: TextEditingController(text: ''),
        hint: 'Description',
        isPass: true,
        onChanged: (value) {
          signInBloc.add(UserDetailDescriptionChanged(value));
        },
      ),
      IconButton(
        onPressed: () {
          signInBloc.add(const UserDetailImageAddClicked());
        },
        icon: const Icon(Icons.add_a_photo),
      ),
      const Divider(height: 50),
      ElevatedButton(
        onPressed: () {
          signInBloc.add(const UserDetailSubmitted());
        },
        child: const Text('Sign In'),
      ),
    ]);
  }
}
