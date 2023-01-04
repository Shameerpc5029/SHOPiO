
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowAlertWidget extends StatelessWidget {
  final String title;
  final String contant;
  final void Function() yesPress;
  const ShowAlertWidget({
    super.key,
    required this.yesPress,
    required this.title,
    required this.contant,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        contant,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'No',
          ),
        ),
        TextButton(
          onPressed: yesPress,
          child: const Text(
            'Yes',
          ),
        ),
      ],
    );
  }
}
