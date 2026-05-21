import 'package:flutter/material.dart';

class LoadedAdviceField extends StatefulWidget {
  final String advice;
  const LoadedAdviceField({super.key, required this.advice});

  @override
  State<LoadedAdviceField> createState() => _LoadedAdviceFieldState();
}

class _LoadedAdviceFieldState extends State<LoadedAdviceField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.orange,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Text(
          widget.advice,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
