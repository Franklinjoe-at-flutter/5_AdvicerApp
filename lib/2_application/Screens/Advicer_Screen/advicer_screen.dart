import 'package:advicer_app/2_application/Core/Services/theme_service.dart';
import 'package:advicer_app/2_application/Screens/Advicer_Screen/advicer_widgets/error_message_field.dart';
import 'package:advicer_app/2_application/Screens/Advicer_Screen/advicer_widgets/get_advice_button.dart';
import 'package:advicer_app/2_application/Screens/Advicer_Screen/advicer_widgets/loaded_advice_field.dart';
import 'package:advicer_app/2_application/Screens/Advicer_Screen/cubit/advicer_cubit.dart';
import 'package:advicer_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AdvcierScreenWrapperProvider extends StatelessWidget {
  const AdvcierScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdvicerCubit>(),
      child: AdvicerScreen(),
    );
  }
}

class AdvicerScreen extends StatelessWidget {
  const AdvicerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advicer"),
        centerTitle: true,
        actions: [
          Consumer<ThemeService>(
            builder: (_, themeService, _) {
              return Switch(
                value: themeService.isDarkModeOn,
                onChanged: (_) {
                  themeService.onChanged();
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdvicerCubit, AdvicerCubitState>(
                  builder: (context, state) {
                    if (state is AdvicerInitialState) {
                      return Text(
                        "Your Advice is waiting for You!",
                        style: TextStyle(fontSize: 22),
                      );
                    } else if (state is AdvicerLoadingState) {
                      return CircularProgressIndicator();
                    } else if (state is AdvicerLoadedState) {
                      return LoadedAdviceField(advice: state.advice);
                    } else if (state is AdvicerErrorState) {
                      return ErrorMessageField(errorMessage: state.message);
                    }
                    return ErrorMessageField(errorMessage: "Oops!");
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: Center(
                child: GetAdviceButton(
                  onTap: () => BlocProvider.of<AdvicerCubit>(
                    context,
                    listen: false,
                  ).adviceRequested(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
