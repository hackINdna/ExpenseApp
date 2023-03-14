import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonHandeler;
  const AdaptiveButton(
      {super.key, required this.buttonText, required this.buttonHandeler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: buttonHandeler,
            child: Text(buttonText),
          )
        : TextButton(
            onPressed: buttonHandeler,
            child: Text(buttonText),
          );
  }
}
