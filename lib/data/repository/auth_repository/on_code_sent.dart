import 'package:firebase_auth/firebase_auth.dart';

import '../../../presentation/screens/authorization_screen/bloc/authorization_bloc.dart';
import '../../../presentation/screens/authorization_screen/bloc/authorization_event.dart' as events;


Future<Object> onCodeSent(String verificationId, int? forceResendingToken,
    AuthorizationBloc bloc, FirebaseAuth _auth) async {
  // adding event in bloc with a function that should be called after the code is submitted
  bloc.add(events.AuthorizationCodeSent(
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
