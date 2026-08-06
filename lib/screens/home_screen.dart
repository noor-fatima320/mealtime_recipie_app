import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color(0xffF7931A),
      ),
      body: const Center(
        child: Text(
          "Home Screen",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
