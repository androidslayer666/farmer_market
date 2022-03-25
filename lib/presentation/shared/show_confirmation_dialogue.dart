import 'package:flutter/material.dart';

void showConfirmationDialog(
    {required Function onConfirm, required BuildContext context, required String text}) {
  showDialog(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Text(text),
            Row(
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    }, child: const Text('OK')),
              ],
            )
          ],
        );
      });
}
