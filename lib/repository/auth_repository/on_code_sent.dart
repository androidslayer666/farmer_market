
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_market/repository/auth_repository/show_code_input_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/screens/phone_enter_screen/bloc/phone_enter_bloc.dart';
import '../../presentation/screens/phone_enter_screen/bloc/phone_enter_event.dart' as events;
import '../constants.dart';
import '../models/user.dart' as models;
import '../storage_repository.dart';

void onCodeSent(String verificationId, int? forceResendingToken,
    BuildContext context, FirebaseAuth _auth) async {

  final bloc = context.read<PhoneEnterBloc>();

  bloc.add(events.PhoneCodeSent((String code) async {
    try {

      //sending the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);

      // Sign the user in
      final result = await _auth.signInWithCredential(credential);

      print(result);
    } catch (e) {
      print(e);
    }

  }));
}
