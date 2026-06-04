import 'package:advicer_app/2_application/Core/Services/theme_service.dart';
import 'package:advicer_app/2_application/Screens/Advicer_Screen/advicer_screen.dart';
import 'package:advicer_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:advicer_app/injection.dart' as di; // di = dependency injection

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: RootAdvicerApp(),
    ),
  );
}

class RootAdvicerApp extends StatelessWidget {
  const RootAdvicerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          themeMode: themeService.isDarkModeOn
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: AdvcierScreenWrapperProvider(),
        );
      },
    );
  }
}
