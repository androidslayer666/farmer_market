import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future showCodeInputDialog(BuildContext context, String verificationId,
        FirebaseAuth auth) {
  TextEditingController controller = TextEditingController();
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Give the code?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: controller,
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop(controller.text.trim());
                },
            )
          ],
        );
      });
}