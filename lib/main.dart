import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MealtimeApp());
}

class MealtimeApp extends StatelessWidget {
  const MealtimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mealtime",
      home: const SplashScreen(),
    );
  }
}
