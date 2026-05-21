import 'package:flutter/material.dart';

class ErrorMessageField extends StatelessWidget {
  final String errorMessage;
  const ErrorMessageField({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.gpp_bad, color: Colors.red, size: 50),
        SizedBox(height: 15),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
        ),
      ],
    );
  }
}
