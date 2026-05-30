import 'package:advicer_app/0_application/Screens/Advicer_Screen/cubit/advicer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAdviceButton extends StatelessWidget {
  const GetAdviceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<AdvicerCubit>(context, listen: false).adviceRequested();
      },
      style: TextButton.styleFrom(backgroundColor: Colors.orange, ),
      icon: Text("Get Advice!", style: TextStyle(color: Colors.white)),
    );
  }
}
