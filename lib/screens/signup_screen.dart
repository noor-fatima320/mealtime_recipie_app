import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: const Color(0xffF7931A),
      ),
      body: const Center(
        child: Text(
          "Sign Up Screen",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
