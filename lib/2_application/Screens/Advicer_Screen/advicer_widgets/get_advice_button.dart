import 'package:flutter/material.dart';

class GetAdviceButton extends StatelessWidget {
  final Function()? onTap;
  const GetAdviceButton({this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap?.call(),
      style: TextButton.styleFrom(backgroundColor: Colors.orange),
      icon: Text("Get Advice!", style: TextStyle(color: Colors.white)),
    );
  }
}
