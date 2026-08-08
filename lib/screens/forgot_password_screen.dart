import 'package:flutter/material.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final PageController _pageController = PageController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final emailFormKey = GlobalKey<FormState>();

  int currentPage = 0;

  String otp = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ForgotEmailScreen(),

            VerificationCodeScreen(),

            ResetPasswordScreen(),

            ResetSuccessScreen(),
          ],
        ),
      ),
    );
  }
}

class ForgotEmailScreen extends StatelessWidget {
  const ForgotEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context
        .findAncestorStateOfType<_ForgotPasswordScreenState>()!;

    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),

        child: Form(
          key: state.emailFormKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 15),

              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(Icons.arrow_back_ios_new),
              ),

              const SizedBox(height: 25),

              const Text(
                "Forgot password",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                "Enter your email for the verification process.",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 35),

              const Text(
                "Email Address",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: state.emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),

                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),

                    borderSide: const BorderSide(
                      color: Color(0xffF7931A),
                      width: 2,
                    ),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  }

                  if (!RegExp(
                    r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return "Invalid email";
                  }

                  return null;
                },
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,

                height: 60,

                child: ElevatedButton(
                  onPressed: () {
                    if (state.emailFormKey.currentState!.validate()) {
                      state.nextPage();
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF7931A),

                    foregroundColor: Colors.black,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: const Text(
                    "Send Code",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context
        .findAncestorStateOfType<_ForgotPasswordScreenState>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const SizedBox(height: 15),

          //--------------------------------
          // Back Button
          //--------------------------------
          IconButton(
            onPressed: () {
              state.previousPage();
            },

            icon: const Icon(Icons.arrow_back_ios_new),
          ),

          const SizedBox(height: 25),

          //--------------------------------
          // Title
          //--------------------------------
          const Text(
            "Enter 4 digit code",

            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(
            "Enter 4 digit code that you receive on your email.",

            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 40),

          //--------------------------------
          // OTP Boxes
          //--------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: List.generate(4, (index) {
              return SizedBox(
                width: 65,
                height: 65,

                child: TextField(
                  textAlign: TextAlign.center,

                  keyboardType: TextInputType.number,

                  maxLength: 1,

                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),

                  decoration: InputDecoration(
                    counterText: "",

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),

                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),

                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffF7931A),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 30),

          //--------------------------------
          // Resend
          //--------------------------------
          Center(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.grey),

                children: [
                  TextSpan(text: "Not received a code? "),

                  TextSpan(
                    text: "Resend",

                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          //--------------------------------
          // Continue Button
          //--------------------------------
          SizedBox(
            width: double.infinity,
            height: 60,

            child: ElevatedButton(
              onPressed: () {
                state.nextPage();
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),

                foregroundColor: Colors.black,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),

              child: const Text(
                "Continue",

                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context
        .findAncestorStateOfType<_ForgotPasswordScreenState>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const SizedBox(height: 15),

          //--------------------------------
          // Back Button
          //--------------------------------
          IconButton(
            onPressed: () {
              state.previousPage();
            },

            icon: const Icon(Icons.arrow_back_ios_new),
          ),

          const SizedBox(height: 25),

          //--------------------------------
          // Title
          //--------------------------------
          const Text(
            "Reset password",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(
            "Set the new password for your account.",

            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 35),

          //--------------------------------
          // Password
          //--------------------------------
          const Text(
            "Password",

            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: state.passwordController,

            obscureText: true,

            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.visibility_outlined),

              filled: true,

              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),

                borderSide: BorderSide(color: Colors.grey.shade300),
              ),

              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF7931A), width: 2),
              ),
            ),
          ),

          const SizedBox(height: 25),

          //--------------------------------
          // Confirm Password
          //--------------------------------
          const Text(
            "Re-enter Password",

            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: state.confirmPasswordController,

            obscureText: true,

            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.visibility_outlined),

              filled: true,

              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),

                borderSide: BorderSide(color: Colors.grey.shade300),
              ),

              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF7931A), width: 2),
              ),
            ),
          ),

          const Spacer(),

          //--------------------------------
          // Button
          //--------------------------------
          SizedBox(
            width: double.infinity,
            height: 60,

            child: ElevatedButton(
              onPressed: () {
                if (state.passwordController.text.isEmpty ||
                    state.confirmPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields")),
                  );

                  return;
                }

                if (state.passwordController.text !=
                    state.confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords do not match")),
                  );

                  return;
                }

                state.nextPage();
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),

                foregroundColor: Colors.black,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),

              child: const Text(
                "Set a New Password",

                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class ResetSuccessScreen extends StatelessWidget {
  const ResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          //--------------------------------
          // Success Icon
          //--------------------------------
          Container(
            width: 140,
            height: 140,

            decoration: const BoxDecoration(
              color: Color(0xff34A853),
              shape: BoxShape.circle,
            ),

            child: const Icon(Icons.check, color: Colors.white, size: 80),
          ),

          const SizedBox(height: 40),

          //--------------------------------
          // Title
          //--------------------------------
          const Text(
            "Password Changed!",

            textAlign: TextAlign.center,

            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 18),

          //--------------------------------
          // Description
          //--------------------------------
          Text(
            "Your password has been changed successfully.",

            textAlign: TextAlign.center,

            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 60),

          //--------------------------------
          // Back To Login Button
          //--------------------------------
          SizedBox(
            width: double.infinity,
            height: 60,

            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),
                foregroundColor: Colors.black,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),

              child: const Text(
                "Back to Login",

                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
