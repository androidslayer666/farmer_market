import 'package:farmer_market/presentation/screens/signin_screen/bloc/sigin_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/auth_repository.dart';
import '../../di/getit_setup.dart';
import '../../shared/text_input_custom.dart';
import 'bloc/signin_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
        ),
        body: BlocProvider(
          create: (context) {
            return SignInBloc(authRepository: locator<AuthRepository>());
          },
          child: SignInScreenBody(),
        ));
  }
}

class SignInScreenBody extends StatelessWidget {
  SignInScreenBody({Key? key}) : super(key: key);

  //final loginController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    final signInBloc = context.read<SignInBloc>();
    return Column(children: [
      TextInputCustom(
        controller: TextEditingController(),
        hint: 'Name',
        onChanged: (value) {
          signInBloc.add(SignInNameChanged(value));
        },
      ),
      TextInputCustom(
        controller: TextEditingController(),
        hint: 'Email',
        onChanged: (value) {
          signInBloc.add(SignInPhoneChanged(value));
        },
      ),
      TextInputCustom(
        controller: TextEditingController(),
        hint: 'Password',
        isPass: true,
        onChanged: (value) {
          signInBloc.add(SignInPasswordChanged(value));
        },
      ),
      IconButton(
        onPressed: () {
          signInBloc.add(const SignInImageAddClicked());
        },
        icon: const Icon(Icons.add_a_photo),
      ),
      const Divider(height: 50),
      ElevatedButton(
        onPressed: () {
          signInBloc.add(const SignInSubmitted());
        },
        child: const Text('Sign In'),
      ),
    ]);
  }
}
