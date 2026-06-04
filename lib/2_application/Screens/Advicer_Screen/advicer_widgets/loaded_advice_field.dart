import 'package:flutter/material.dart';

class LoadedAdviceField extends StatelessWidget {
  static String emptyAdvice = "what should i do with an empty advice ?!";
  final String advice;
  const LoadedAdviceField({super.key, required this.advice});

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
          advice.isNotEmpty ? '''"$advice"''' : emptyAdvice,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
