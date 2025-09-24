import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netxlif/core/theme.dart';
import 'package:netxlif/features/welcomes/presentations/screens/on_boarding_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(retry: (retryCount, error) => null, child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(primary: primaryColor),
      ),
      home: OnBoardingScreen(),
    );
  }
}
