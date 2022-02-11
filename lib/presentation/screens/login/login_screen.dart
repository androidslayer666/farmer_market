import 'package:farmer_market/presentation/screens/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/auth_repository.dart';
import '../../di/getit_setup.dart';
import '../../navigation/routes.dart';
import '../../shared/text_input_custom.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
      body: BlocProvider(
          create: (context) {
            return LoginBloc(authRepository: locator<AuthRepository>());
          },
          child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.loginStatus == LoginStatus.success) {
                  print("SUCCESSFUL LOGIN!!!!");
                  Navigator.of(context).pushNamed(mainRoute);
                }
              },
              child: LoginScreenBody())),
    );
  }
}

class LoginScreenBody extends StatelessWidget {
  LoginScreenBody({Key? key}) : super(key: key);

  // final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Column(
      children: [
        TextInputCustom(
          controller: TextEditingController(),
          hint: 'Phone',
          onChanged: (email) => loginBloc.add(LoginPhoneChanged(email)),
        ),
        TextInputCustom(
          controller: TextEditingController(),
          hint: 'Password',
          isPass: true,
          onChanged: (password) =>
              loginBloc.add(LoginPasswordChanged(password)),
        ),
        const Divider(
          height: 100,
        ),
        ElevatedButton(
            onPressed: () {
              loginBloc.add(LoginSubmitted());
              //loginController.logIn((){Navigator.of(context).pushNamed(mainRoute);});
            },
            child: const Text('Log In')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(signInRoute);
            },
            child: const Text('Sign In'))
      ],
    );
  }
}
