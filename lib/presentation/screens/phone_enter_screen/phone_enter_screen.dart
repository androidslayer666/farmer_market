import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/auth_repository/auth_repository.dart';
import '../../di/getit_setup.dart';
import '../../navigation/routes.dart';
import '../../shared/text_input_custom.dart';
import 'bloc/phone_enter_bloc.dart';
import 'bloc/phone_enter_event.dart';
import 'bloc/phone_enter_state.dart';

class PhoneEnterScreen extends StatelessWidget {
  const PhoneEnterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
      body: BlocProvider(
          create: (context) {
            return PhoneEnterBloc(authRepository: locator<AuthRepository>());
          },
          child: BlocListener<PhoneEnterBloc, PhoneEnterState>(
              listener: (context, state) {
                // if (state.loginStatus == .success) {
                //   print("SUCCESSFUL LOGIN!!!!");
                //   Navigator.of(context).pushNamed(mainRoute);
                // }
              },
              child: PhoneEnterScreenBody())),
    );
  }
}

class PhoneEnterScreenBody extends StatefulWidget {
  const PhoneEnterScreenBody({Key? key}) : super(key: key);

  @override
  State<PhoneEnterScreenBody> createState() => _PhoneEnterScreenBodyState();
}

class _PhoneEnterScreenBodyState extends State<PhoneEnterScreenBody> {
  late PhoneEnterBloc loginBloc;
  var codeIsSent = false;
  late TextEditingController phoneController;
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    codeController = TextEditingController();
    loginBloc = context.read<PhoneEnterBloc>();
  }

  @override
  Widget build(BuildContext context) {
    //final loginBloc = context.read<PhoneEnterBloc>();
    return BlocBuilder<PhoneEnterBloc, PhoneEnterState>(
        builder: (context, state) {
      return Column(
        children: [
          if (!state.codeIsSent)
            TextInputCustom(
              controller: phoneController,
              hint: 'Phone',
              onChanged: (phone) =>
                  loginBloc.add(PhoneEnterPhoneChanged(phone)),
            )
          else
            TextInputCustom(
              controller: codeController,
              hint: 'Code',
              onChanged: (code) => loginBloc.add(PhoneEnterCodeChanged(code)),
            ),
          const Divider(
            height: 100,
          ),
          if (!state.codeIsSent)
            ElevatedButton(
                onPressed: () {
                  loginBloc.add(PhoneEnterSubmitted(context));
                  //loginController.logIn((){Navigator.of(context).pushNamed(mainRoute);});
                },
                child: const Text('Send Code'))
          else
            ElevatedButton(
                onPressed: () {
                  loginBloc.add(const OnCodeSubmitted());
                  //loginController.logIn((){Navigator.of(context).pushNamed(mainRoute);});
                },
                child: const Text('Confirm Code')),
        ],
      );
    });
  }
}
