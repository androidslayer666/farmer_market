import 'dart:async';

import 'package:farmer_market/presentation/navigation/navigation_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../../app/di/getit_setup.dart';
import '../../../generated/l10n.dart';
import '../../../data/repository/auth_repository/auth_repository.dart';
import '../../navigation/routes.dart';
import '../../shared/text_input_custom.dart';
import '../../shared/utils.dart';
import 'bloc/authorization_bloc.dart';
import 'bloc/authorization_event.dart';
import 'bloc/authorization_state.dart';

class PhoneEnterScreen extends StatelessWidget {
  const PhoneEnterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) {
            return AuthorizationBloc(authRepository: locator<AuthRepository>());
          },
          child: BlocListener<AuthorizationBloc, AuthorizationState>(
              listener: (context, state) {
                if (state.loginStatus == PhoneLoginStatus.success) {
                  //print(state);
                  Navigator.of(context).pushNamed(mainRoute);
                }
              },
              child: const PhoneEnterScreenBody())),
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
  int timerCount = 60;

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
    final authBloc = context.read<AuthorizationBloc>();
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
        listener: (context, state) {
      if (state.loginStatus == PhoneLoginStatus.success) {
        if (state.haveUserInfoOnServer == true) {
          navigateToMainScreen(context, clearStack: true);
        } else {
          navigateToEditUserScreen(context, clearStack: true);
        }
      }
      if (state.timerIsSet == true) {
        Timer.periodic(Duration(seconds: 1), (timer) {
          print(timerCount);
          timerCount--;
          if (timerCount == 0) {
            print('Cancel timer');
            timer.cancel();
            authBloc.add(const AuthorizationTimerIsOver());
            timerCount = 60;
          }
          setState(() {});
        });
      }
      if (state.loginStatus == PhoneLoginStatus.failure) {
        //todo
        print('failure');
      }
    }, builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          if (state.loginStatus == PhoneLoginStatus.codeIsSent ||
              state.loginStatus == PhoneLoginStatus.codeSubmitted ||
              state.loginStatus == PhoneLoginStatus.success) {
            authBloc.add(const AuthorizationResetState());
          }
          return false;
        },
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo1.png'),
              if (state.loginStatus == PhoneLoginStatus.unknown ||
                  state.loginStatus == PhoneLoginStatus.awaitingCode ||
                  state.loginStatus == PhoneLoginStatus.failure)
                AuthorizationPhonePage(
                  phoneController: phoneController,
                  status: state.loginStatus,
                  phoneIsValid: state.phoneIsValid,
                ),
              if (state.loginStatus == PhoneLoginStatus.codeIsSent ||
                  state.loginStatus == PhoneLoginStatus.codeSubmitted ||
                  state.loginStatus == PhoneLoginStatus.success)
                AuthorizationCodePage(
                  status: state.loginStatus,
                  timerIsSet: state.timerIsSet,
                  timerCount: timerCount,
                ),
              if (state.loginStatus == PhoneLoginStatus.failure)
                Center(
                  child: Row(
                    children: [
                      const Icon(Icons.error),
                      Text(S.of(context).phoneEnterScreen_serverResponseGaveBad)
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

class AuthorizationPhonePage extends StatelessWidget {
  const AuthorizationPhonePage(
      {Key? key,
      required this.phoneController,
      required this.status,
      required this.phoneIsValid})
      : super(key: key);

  final TextEditingController phoneController;
  final PhoneLoginStatus status;
  final bool? phoneIsValid;

  @override
  Widget build(BuildContext context) {
    final authorizationBloc = context.read<AuthorizationBloc>();
    return Column(
      children: [
        TextInputCustom(
          icon: Icons.phone,
          controller: phoneController,
          hint: S.of(context).phoneEnterScreen_phone,
          textInputType: TextInputType.phone,
          errorText: phoneIsValid == false
              ? S.of(context).phoneEnterScreen_enterCorrectPhone
              : null,
          textInputFormatter: NumberTextInputFormatter(),
          onChanged: (phone) =>
              authorizationBloc.add(AuthorizationPhoneChanged(phone)),
        ),
        if (status == PhoneLoginStatus.awaitingCode)
          const CircularProgressIndicator(),
        ElevatedButton(
            onPressed: () {
              authorizationBloc.add(AuthorizationPhoneSubmitted(context));
              //loginController.logIn((){Navigator.of(context).pushNamed(mainRoute);});
            },
            child: Text(S.of(context).phoneEnterScreen_sendCode))
      ],
    );
  }
}

class AuthorizationCodePage extends StatelessWidget {
  const AuthorizationCodePage(
      {Key? key,
      required this.status,
      required this.timerIsSet,
      required this.timerCount})
      : super(key: key);

  final PhoneLoginStatus status;
  final bool timerIsSet;
  final int timerCount;

  @override
  Widget build(BuildContext context) {
    final authorizationBloc = context.read<AuthorizationBloc>();
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VerificationCode(
            textStyle: const TextStyle(fontSize: 20.0),
            keyboardType: TextInputType.number,
            length: 6,
            cursorColor: Colors.blue,
            onCompleted: (String code) {
              authorizationBloc.add(AuthorizationCodeChanged(code));
            },
            onEditing: (bool value) {},
          ),
          if (status == PhoneLoginStatus.codeSubmitted)
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ElevatedButton(
              onPressed: () {
                authorizationBloc.add(const AuthorizationCodeSubmitted());
                //loginController.logIn((){Navigator.of(context).pushNamed(mainRoute);});
              },
              child: Text(S.of(context).phoneEnterScreen_confirmCode)),
          if (timerIsSet) Text(timerCount.toString())
        ],
      ),
    );
  }
}
