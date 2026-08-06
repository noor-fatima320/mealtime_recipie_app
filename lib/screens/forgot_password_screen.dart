import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: const Color(0xffF7931A),
      ),
      body: const Center(
        child: Text(
          "Forgot Password Screen",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
