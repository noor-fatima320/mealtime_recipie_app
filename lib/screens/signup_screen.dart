import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool agreeTerms = false;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //--------------------------------
                // Back Button
                //--------------------------------
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(Icons.arrow_back_ios_new, size: 26),
                ),

                const SizedBox(height: 18),

                //--------------------------------
                // Title
                //--------------------------------
                const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                ),

                const SizedBox(height: 32),

                //--------------------------------
                // Full Name
                //--------------------------------
                const Text(
                  "Full Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: nameController,

                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),

                      borderSide: const BorderSide(color: Colors.green),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),

                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter your full name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 22),

                //--------------------------------
                // Email Address
                //--------------------------------
                const Text(
                  "Email Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.green),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your email";
                    }

                    if (!RegExp(
                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return "Invalid email";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 22),

                //--------------------------------
                // Password
                //--------------------------------
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,

                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.green),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your password";
                    }

                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 22),

                //--------------------------------
                // Terms & Conditions
                //--------------------------------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: agreeTerms,
                      activeColor: const Color(0xffF7931A),

                      onChanged: (value) {
                        setState(() {
                          agreeTerms = value!;
                        });
                      },
                    ),

                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                          children: [
                            TextSpan(text: "I agree to Mealtime’s "),
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                //--------------------------------
                // Create Account Button
                //--------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      if (!agreeTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please accept Terms & Conditions"),
                          ),
                        );
                        return;
                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF7931A),
                      foregroundColor: Colors.black,
                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    child: const Text(
                      "Create an Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                //--------------------------------
                // OR Divider
                //--------------------------------
                const SizedBox(height: 28),

                Row(
                  children: [
                    const Expanded(child: Divider()),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 28),

                //--------------------------------
                // Google Button
                //--------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Google Sign Up
                    },

                    icon: Image.asset("assets/icons/google.png", width: 26),

                    label: const Text(
                      "Sign Up with Google",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,

                      side: BorderSide(color: Colors.grey.shade300),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                //--------------------------------
                // Facebook Button
                //--------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Facebook Sign Up
                    },

                    icon: Image.asset("assets/icons/facebook.png", width: 26),

                    label: const Text(
                      "Sign Up with Facebook",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1877F2),
                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 90),

                //--------------------------------
                // Already Member
                //--------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already a member? ",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
