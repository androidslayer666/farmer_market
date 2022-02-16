import 'package:firebase_auth/firebase_auth.dart';

import '../../presentation/screens/phone_enter_screen/bloc/phone_enter_bloc.dart';
import '../../presentation/screens/phone_enter_screen/bloc/phone_enter_event.dart'
    as events;

Future<Object> onCodeSent(String verificationId, int? forceResendingToken,
    PhoneEnterBloc bloc, FirebaseAuth _auth) async {
  // adding event in bloc with a function that should be called after the code is submitted
  bloc.add(events.PhoneCodeSent(
      onCodeSubmitted: (String code) async {
    try {
      //sending the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);

      // Sign the user in
      final result = await _auth.signInWithCredential(credential);

      return result;
    } catch (e) {
      return (e);
    }
  }));
  return '';
}
