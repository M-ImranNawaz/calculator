import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  const InputButton({Key? key, required this.onPressed, required this.title, required this.t})
      : super(key: key);
  final Function() onPressed;
  final Widget title;
  final String t;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: OutlinedButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            minimumSize: const Size(75, 70),
            backgroundColor: t == "C"
                ? Colors.red
                : t == "="
                    ? Colors.blue
                    : Colors.white,
          ),
          child: title),
    );
  }
}
