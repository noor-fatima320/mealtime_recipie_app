import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  Future<void> showNotificationPopup(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.25),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Center(
            child: Container(
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 22),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '"Mealtim" Would Like To Send You Notifications',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Notifications may include alerts,\nsounds, and icon badges.\nThese can be configured in Settings.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(221, 11, 5, 5),
                        height: 1.35,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  Divider(height: 1, color: Colors.grey.shade300),

                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            onPressed: () {
                              Navigator.pop(context);

                              setState(() {
                                reminderEnabled = false;
                              });

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Don't Allow",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),

                        VerticalDivider(width: 1, color: Colors.grey.shade300),

                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            onPressed: () async {
                              Navigator.pop(context);

                              await requestNotificationPermission();

                              setState(() {
                                reminderEnabled = true;
                              });

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Allow",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int currentPage = 0;
  //-------------------------
  // Diet Selection
  //-------------------------

  final List<String> diets = [
    "Classic",
    "Low Carb",
    "Keto",
    "Flexitarian",
    "Paleo",
    "Vegetarian",
    "Pescetarian",
    "Vegan",
  ];

  List<int> selectedDiets = [];
  //-------------------------
  // Allergies
  //-------------------------

  final List<String> allergies = [
    "Gluten",
    "Peanut",
    "Tree Nut",
    "Soy",
    "Sesame",
    "Mustard",
    "Sulfite",
    "Nightshade",
  ];

  List<int> selectedAllergies = [];
  //-------------------------
  // Dislikes
  //-------------------------

  final List<String> dislikes = [
    "Avocado",
    "Beets",
    "Bell Peppers",
    "Brussels Sprouts",
    "Cauliflower",
    "Eggplant",
    "Mushrooms",
    "Olives",
    "Quinoa",
    "Tofu",
    "Turnips",
  ];

  List<int> selectedDislikes = [];
  //-------------------------
  // Weekly Reminder
  //-------------------------

  bool reminderEnabled = true;

  String selectedTime = "10:00 AM";

  String selectedDay = "Sundays";

  final List<String> reminderTimes = [
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
  ];

  final List<String> reminderDays = [
    "Mondays",
    "Tuesdays",
    "Wednesdays",
    "Thursdays",
    "Fridays",
    "Saturdays",
    "Sundays",
  ];
  //-------------------------
  // Servings
  //-------------------------

  final List<Map<String, String>> servings = [
    {"title": "2 servings", "subtitle": "for two, or one with leftovers"},
    {
      "title": "4 servings",
      "subtitle": "for four, or two-three with leftovers",
    },
    {"title": "6 servings", "subtitle": "for a family of 5+"},
  ];

  int selectedServing = 0;

  void nextPage() {
    if (currentPage < 7) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),

        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> requestNotificationPermission() async {
    await Permission.notification.request();
  }

  void previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),

        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },

          children: [
            WelcomeSlide1(),

            WelcomeSlide2(),

            WelcomeSlide3(),

            DietScreen(),

            AllergyScreen(),

            DislikesScreen(),

            ServingScreen(),

            ReminderScreen(),
          ],
        ),
      ),
    );
  }
}

class WelcomeSlide1 extends StatelessWidget {
  const WelcomeSlide1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Column(
        children: [
          const SizedBox(height: 8),

          //--------------------------------
          // Back Button
          //--------------------------------
          Align(
            alignment: Alignment.centerLeft,

            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },

              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 28,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 10),

          //--------------------------------
          // Illustration
          //--------------------------------
          Expanded(
            flex: 5,

            child: Image.asset(
              "assets/images/welcome1.png",
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 18),

          //--------------------------------
          // Dots
          //--------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [buildDot(true), buildDot(false), buildDot(false)],
          ),

          const SizedBox(height: 35),

          //--------------------------------
          // Heading
          //--------------------------------
          const Text(
            "Personalized meal\nplanning",

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 40,

              fontWeight: FontWeight.w800,

              height: 1.1,

              color: Colors.black,
            ),
          ),

          const SizedBox(height: 25),

          //--------------------------------
          // Description
          //--------------------------------
          const Text(
            "Pick your week's meals in minutes. With\n"
            "over 200 personalization options, eat\n"
            "exactly how you want to eat.",

            textAlign: TextAlign.center,

            style: TextStyle(fontSize: 20, color: Colors.grey, height: 1.6),
          ),

          //------------------------------
          // Continue Button
          //------------------------------
          SizedBox(
            width: double.infinity,
            height: 62,
            child: ElevatedButton(
              onPressed: () {
                final parentState = context
                    .findAncestorStateOfType<_OnboardingScreenState>();

                parentState?.nextPage();
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),
                foregroundColor: Colors.black,
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
          ),

          const SizedBox(height: 18),

          //------------------------------
          // Skip
          //------------------------------
          GestureDetector(
            onTap: () {
              // Login Screen
              // Next part me Named Route use krenge
            },

            child: const Text(
              "Skip",

              style: TextStyle(
                fontSize: 20,

                fontWeight: FontWeight.w500,

                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 28),
        ],
      ),
    );
  }

  static Widget buildDot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),

      margin: const EdgeInsets.symmetric(horizontal: 5),

      width: 12,

      height: 12,

      decoration: BoxDecoration(
        color: active ? const Color(0xffF7931A) : Colors.grey.shade300,

        shape: BoxShape.circle,
      ),
    );
  }
}

class WelcomeSlide2 extends StatelessWidget {
  const WelcomeSlide2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Column(
        children: [
          const SizedBox(height: 8),

          //--------------------------------
          // Back Button
          //--------------------------------
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                final parentState = context
                    .findAncestorStateOfType<_OnboardingScreenState>();

                parentState?.previousPage();
              },

              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 28,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 10),

          //--------------------------------
          // Image
          //--------------------------------
          Expanded(
            flex: 5,
            child: Image.asset(
              "assets/images/welcome2.png",
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 18),

          //--------------------------------
          // Dots
          //--------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WelcomeSlide1.buildDot(false),

              WelcomeSlide1.buildDot(true),

              WelcomeSlide1.buildDot(false),
            ],
          ),

          const SizedBox(height: 35),

          //--------------------------------
          // Heading
          //--------------------------------
          const Text(
            "Simple, stress-free\ngrocery shopping",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 20),

          //--------------------------------
          // Description
          //--------------------------------
          const Text(
            'Grocery shop once per week with an\norganized "done for you" shopping list.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey, height: 1.5),
          ),

          //--------------------------------------------------
          // Continue Button
          //--------------------------------------------------
          SizedBox(
            width: double.infinity,
            height: 62,
            child: ElevatedButton(
              onPressed: () {
                final parentState = context
                    .findAncestorStateOfType<_OnboardingScreenState>();

                parentState?.nextPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
          ),

          const SizedBox(height: 18),

          //--------------------------------------------------
          // Skip
          //--------------------------------------------------
          GestureDetector(
            onTap: () {
              // Login Screen
              // Final navigation baad me Named Routes se hogi.
            },

            child: const Text(
              "Skip",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

class WelcomeSlide3 extends StatelessWidget {
  const WelcomeSlide3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Column(
        children: [
          const SizedBox(height: 8),

          //--------------------------------
          // Back Button
          //--------------------------------
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                final parentState = context
                    .findAncestorStateOfType<_OnboardingScreenState>();

                parentState?.previousPage();
              },

              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 28,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 10),

          //--------------------------------
          // Illustration
          //--------------------------------
          Expanded(
            flex: 5,
            child: Image.asset(
              "assets/images/welcome3.png",
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 18),

          //--------------------------------
          // Dots
          //--------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WelcomeSlide1.buildDot(false),

              WelcomeSlide1.buildDot(false),

              WelcomeSlide1.buildDot(true),
            ],
          ),

          const SizedBox(height: 35),

          //--------------------------------
          // Heading
          //--------------------------------
          const Text(
            "Delicious, healthy meals\nmade easy",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w800,
              height: 1.1,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 22),

          //--------------------------------
          // Description
          //--------------------------------
          const Text(
            "Easily cook healthy, delicious meals in\nabout 30 minutes, from start to finish.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey, height: 1.5),
          ),

          //----------------------------------------------------
          // Continue Button
          //----------------------------------------------------
          SizedBox(
            width: double.infinity,
            height: 62,
            child: ElevatedButton(
              onPressed: () {
                final parentState = context
                    .findAncestorStateOfType<_OnboardingScreenState>();

                parentState?.nextPage();
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),
                foregroundColor: Colors.black,
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
          ),

          const SizedBox(height: 18),

          //----------------------------------------------------
          // Skip
          //----------------------------------------------------
          GestureDetector(
            onTap: () {
              // Last me Login Screen
              // Named Route use krenge
            },

            child: const Text(
              "Skip",

              style: TextStyle(
                fontSize: 20,

                fontWeight: FontWeight.w500,

                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_OnboardingScreenState>()!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),

        child: Column(
          children: [
            const SizedBox(height: 10),

            //--------------------------------
            // Back Button
            //--------------------------------
            Align(
              alignment: Alignment.centerLeft,

              child: IconButton(
                onPressed: () {
                  state.previousPage();
                },

                icon: const Icon(Icons.arrow_back_ios_new, size: 28),
              ),
            ),

            const SizedBox(height: 12),

            //--------------------------------
            // Progress Bar
            //--------------------------------
            Row(
              children: [
                progress(true),

                progress(false),

                progress(false),

                progress(false),

                progress(false),
              ],
            ),

            const SizedBox(height: 35),

            //--------------------------------
            // Title
            //--------------------------------
            const Align(
              alignment: Alignment.centerLeft,

              child: Text(
                "Pick your diet",

                style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800),
              ),
            ),

            const SizedBox(height: 35),
            Expanded(
              child: ListView.builder(
                itemCount: state.diets.length,
                itemBuilder: (context, index) {
                  final selected = state.selectedDiets.contains(index);

                  return GestureDetector(
                    onTap: () {
                      state.setState(() {
                        if (state.selectedDiets.contains(index)) {
                          state.selectedDiets.remove(index);
                        } else {
                          state.selectedDiets.add(index);
                        }
                      });
                    },

                    child: Container(
                      margin: const EdgeInsets.only(bottom: 18),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),

                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xffFFE8C4)
                            : Colors.white,

                        borderRadius: BorderRadius.circular(22),

                        border: Border.all(
                          color: selected
                              ? const Color(0xffF7931A)
                              : Colors.grey.shade300,
                        ),
                      ),

                      child: Text(
                        state.diets[index],

                        style: const TextStyle(
                          fontSize: 22,

                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 62,
              child: ElevatedButton(
                onPressed: () {
                  state.nextPage();
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7931A),
                  foregroundColor: Colors.black,
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

Widget progress(bool active) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      decoration: BoxDecoration(
        color: active ? const Color(0xff34A853) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

class AllergyScreen extends StatelessWidget {
  const AllergyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_OnboardingScreenState>()!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 10),

            //--------------------------------
            // Back Button
            //--------------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  state.previousPage();
                },
                icon: const Icon(Icons.arrow_back_ios_new, size: 28),
              ),
            ),

            const SizedBox(height: 12),

            //--------------------------------
            // Progress Bar
            //--------------------------------
            Row(
              children: [
                progress(true),
                progress(true),
                progress(false),
                progress(false),
                progress(false),
              ],
            ),

            const SizedBox(height: 28),

            //--------------------------------
            // Title
            //--------------------------------
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Any allergies?",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
              ),
            ),

            const SizedBox(height: 30),

            //--------------------------------
            // Allergy Options
            //--------------------------------
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 14,
                  children: List.generate(state.allergies.length, (index) {
                    final selected = state.selectedAllergies.contains(index);

                    return GestureDetector(
                      onTap: () {
                        state.setState(() {
                          if (selected) {
                            state.selectedAllergies.remove(index);
                          } else {
                            state.selectedAllergies.add(index);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xffFFE8C4)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: selected
                                ? const Color(0xffF7931A)
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          state.allergies[index],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //--------------------------------
            // Continue Button
            //--------------------------------
            SizedBox(
              width: double.infinity,
              height: 62,
              child: ElevatedButton(
                onPressed: () {
                  state.nextPage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7931A),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class DislikesScreen extends StatelessWidget {
  const DislikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_OnboardingScreenState>()!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 10),

            //--------------------------------
            // Back Button
            //--------------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  state.previousPage();
                },
                icon: const Icon(Icons.arrow_back_ios_new, size: 28),
              ),
            ),

            const SizedBox(height: 12),

            //--------------------------------
            // Progress Bar
            //--------------------------------
            Row(
              children: [
                progress(true),
                progress(true),
                progress(true),
                progress(false),
                progress(false),
              ],
            ),

            const SizedBox(height: 28),

            //--------------------------------
            // Title
            //--------------------------------
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "How about dislikes?",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800),
              ),
            ),

            const SizedBox(height: 30),

            //--------------------------------
            // Dislike Options
            //--------------------------------
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 14,
                  children: List.generate(state.dislikes.length, (index) {
                    final selected = state.selectedDislikes.contains(index);

                    return GestureDetector(
                      onTap: () {
                        state.setState(() {
                          if (selected) {
                            state.selectedDislikes.remove(index);
                          } else {
                            state.selectedDislikes.add(index);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xffFFE8C4)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: selected
                                ? const Color(0xffF7931A)
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          state.dislikes[index],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //--------------------------------
            // Continue Button
            //--------------------------------
            SizedBox(
              width: double.infinity,
              height: 62,
              child: ElevatedButton(
                onPressed: () {
                  state.nextPage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7931A),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class ServingScreen extends StatefulWidget {
  const ServingScreen({super.key});

  @override
  State<ServingScreen> createState() => _ServingScreenState();
}

class _ServingScreenState extends State<ServingScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_OnboardingScreenState>()!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 10),

            //--------------------------------
            // Back Button
            //--------------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  state.previousPage();
                },
                icon: const Icon(Icons.arrow_back_ios_new, size: 28),
              ),
            ),

            const SizedBox(height: 12),

            //--------------------------------
            // Progress Bar
            //--------------------------------
            Row(
              children: [
                progress(true),
                progress(true),
                progress(true),
                progress(true),
                progress(false),
              ],
            ),

            const SizedBox(height: 30),

            //--------------------------------
            // Title
            //--------------------------------
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "How many servings per\nmeal?",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
            ),

            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: state.servings.length,
                itemBuilder: (context, index) {
                  final selected = state.selectedServing == index;

                  return GestureDetector(
                    onTap: () {
                      state.setState(() {
                        state.selectedServing = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xffFFE8C4)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: selected
                              ? const Color(0xffF7931A)
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.servings[index]["title"]!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            state.servings[index]["subtitle"]!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 62,
              child: ElevatedButton(
                onPressed: () {
                  state.nextPage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7931A),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_OnboardingScreenState>()!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 10),

            //--------------------------------
            // Back Button
            //--------------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  state.previousPage();
                },
                icon: const Icon(Icons.arrow_back_ios_new, size: 28),
              ),
            ),

            const SizedBox(height: 12),

            //--------------------------------
            // Progress Bar
            //--------------------------------
            Row(
              children: [
                progress(true),
                progress(true),
                progress(true),
                progress(true),
                progress(true),
              ],
            ),

            const SizedBox(height: 30),

            //--------------------------------
            // Title
            //--------------------------------
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Set a weekly reminder",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800),
              ),
            ),

            const SizedBox(height: 35),

            //--------------------------------
            // Reminder Row
            //--------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "Remind me to make a meal plan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),

                Switch(
                  value: state.reminderEnabled,

                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xffF7931A),

                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.shade400,

                  onChanged: (value) {
                    state.setState(() {
                      state.reminderEnabled = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            //--------------------------------
            // Time Dropdown
            //--------------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),

                border: Border.all(color: Colors.grey.shade300),
              ),

              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state.selectedTime,

                  isExpanded: true,

                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 32),

                  items: state.reminderTimes.map((time) {
                    return DropdownMenuItem(
                      value: time,
                      child: Text(
                        "at $time",
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    state.setState(() {
                      state.selectedTime = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            //--------------------------------
            // Day Dropdown
            //--------------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),

                border: Border.all(color: Colors.grey.shade300),
              ),

              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state.selectedDay,

                  isExpanded: true,

                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 32),

                  items: state.reminderDays.map((day) {
                    return DropdownMenuItem(
                      value: day,
                      child: Text(
                        "on $day",
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    state.setState(() {
                      state.selectedDay = value!;
                    });
                  },
                ),
              ),
            ),

            const Spacer(),

            //--------------------------------
            // Done Button
            //--------------------------------
            SizedBox(
              width: double.infinity,
              height: 62,
              child: ElevatedButton(
                onPressed: () {
                  state.showNotificationPopup(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7931A),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
