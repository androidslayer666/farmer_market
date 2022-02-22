import 'package:farmer_market/presentation/navigation/navigation_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../app/di/getit_setup.dart';
import '../../../repository/auth_repository/auth_repository.dart';
import '../../navigation/routes.dart';
import '../../shared/text_input_custom.dart';
import '../../shared/utils.dart';
import 'bloc/phone_enter_bloc.dart';
import 'bloc/phone_enter_event.dart';
import 'bloc/phone_enter_state.dart';

class PhoneEnterScreen extends StatelessWidget {
  const PhoneEnterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) {
            return PhoneEnterBloc(authRepository: locator<AuthRepository>());
          },
          child: BlocListener<PhoneEnterBloc, PhoneEnterStateFreezed>(
              listener: (context, state) {
                if (state.loginStatus == PhoneLoginStatus.success) {
                  print(state);
                  Navigator.of(context).pushNamed(mainRoute);
                }
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
  late TextEditingController phoneController;
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<PhoneEnterBloc>();
    return BlocConsumer<PhoneEnterBloc, PhoneEnterStateFreezed>(
        listener: (context, state) {
          print(state.haveUserInfoOnServer);
      if (state.loginStatus == PhoneLoginStatus.success) {
        if(state.haveUserInfoOnServer == true){
          navigateToMainScreen(context, clearStack: true);
        }else {
          navigateToUserDetailScreen(context, clearStack: true);
        }
      }
    }, builder: (context, state) {
      //print(state);
      return WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Image.asset('assets/images/logo1.png'),
              if (state.codeIsSent == false)
                TextInputCustom(
                  icon: const Icon(Icons.phone),
                  controller: phoneController,
                  hint: 'Phone',
                  textInputType: TextInputType.phone,
                  textInputFormatter: NumberTextInputFormatter(),
                  onChanged: (phone) =>
                      loginBloc.add(PhoneEnterPhoneChanged(phone)),
                )
              else
                VerificationCode(
                  textStyle: const TextStyle(fontSize: 20.0),
                  keyboardType: TextInputType.number,
                  length: 6,
                  cursorColor: Colors.blue,
                  onCompleted: (String code) {
                    loginBloc.add(PhoneEnterCodeChanged(code));
                  },
                  onEditing: (bool value) {},
                ),
              // only show if equals false to not showing initially
              if (state.phoneIsValid == false)
                Center(
                  child: Row(
                    children: const [
                      Icon(Icons.error),
                      Text('Please enter correct phone number')
                    ],
                  ),
                ),
              const Divider(
                height: 100,
              ),
              if (state.codeIsSent == false)
                ElevatedButton(
                    onPressed: () {
                      loginBloc.add(PhoneEnterSubmitted(context));
                      //loginController.logIn((){Navigator.of(context).pushNamed(mainRoute);});
                    },
                    child: const Text('Send Code'))
              else if (state.isLoading == true)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                    onPressed: () {
                      loginBloc.add(const OnCodeSubmitted());
                      //loginController.logIn((){Navigator.of(context).pushNamed(mainRoute);});
                    },
                    child: const Text('Confirm Code')),
              if (state.loginStatus == PhoneLoginStatus.failure)
                Center(
                  child: Row(
                    children: const [
                      Icon(Icons.error),
                      Text('Server response gave bad result, please try again')
                    ],
                  ),
                )
            ],
          ),
        )),
      );
    });
  }
}
