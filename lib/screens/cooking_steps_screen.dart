import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/meal_data.dart';

class CookingStepsScreen extends StatelessWidget {
  final Meal meal;
  final int currentStep;

  const CookingStepsScreen({
    super.key,
    required this.meal,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),
      body: SafeArea(
        child: Column(
          children: [
            // BACK
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context, currentStep);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: meal.instructions.length,
                itemBuilder: (context, index) {
                  final instruction = meal.instructions[index];

                  return InkWell(
                    onTap: () {
                      Navigator.pop(context, index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25,
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              instruction.text,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: index == currentStep
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                height: 1.3,
                              ),
                            ),
                          ),

                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 15),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        showQuitDialog(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Leave Cooking Mode",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, currentStep);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF7931A),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Continue Cooking",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showQuitDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Quit Cooking",
      barrierColor: Colors.black.withOpacity(.25),
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(.05)),
            ),

            Center(
              child: Container(
                margin: const EdgeInsets.all(25),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Leave Cooking Mode?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Your current cooking progress will be kept.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Continue Cooking"),
                      ),
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context, "leave");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF7931A),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("Leave Cooking Mode"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
