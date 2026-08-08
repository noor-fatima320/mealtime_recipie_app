import 'package:flutter/material.dart';

import 'groceries_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import 'select_meal_plan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),

            //--------------------------------
            // Empty Area
            //--------------------------------
            Expanded(
              flex: 8,

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      "Your personalized\nmeal plan",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      "Plan your meals for the entire week in\nminutes. Build your first meal plan to\nget started!",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: 320,
                      height: 58,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SelectMealPlanScreen(),
                            ),
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
                          "Build Your First Meal Plan",

                          style: TextStyle(
                            fontSize: 18,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //--------------------------------
            // Bottom Navigation
            //--------------------------------
            Container(
              height: 90,

              decoration: const BoxDecoration(
                color: Colors.white,

                border: Border(top: BorderSide(color: Color(0xffE6E6E6))),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  //--------------------------------
                  // Meal Plan
                  //--------------------------------
                  navItem(
                    image: "assets/icons/mealplan.png",

                    title: "Meal Plan",

                    selected: currentIndex == 0,

                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                  ),

                  //--------------------------------
                  // Groceries
                  //--------------------------------
                  navItem(
                    image: "assets/icons/groceries.png",
                    title: "Groceries",
                    selected: currentIndex == 1,
                    onTap: () async {
                      setState(() {
                        currentIndex = 1;
                      });

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GroceriesScreen(),
                        ),
                      );

                      if (mounted) {
                        setState(() {
                          currentIndex = 0;
                        });
                      }
                    },
                  ),

                  //--------------------------------
                  // Favorites
                  //--------------------------------
                  navItem(
                    image: "assets/icons/favorite.png",

                    title: "Favorites",

                    selected: currentIndex == 2,
                    onTap: () {
                      setState(() {
                        currentIndex = 2;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavoritesScreen(),
                        ),
                      );
                    },
                  ),

                  //--------------------------------
                  // Settings
                  //--------------------------------
                  navItem(
                    image: "assets/icons/settings.png",

                    title: "Settings",

                    selected: currentIndex == 3,

                    onTap: () {
                      setState(() {
                        currentIndex = 3;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem({
    required String image,

    required String title,

    required bool selected,

    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Image.asset(
            image,

            width: 26,

            height: 26,

            color: selected ? const Color(0xffF7931A) : Colors.grey,
          ),

          const SizedBox(height: 6),

          Text(
            title,

            style: TextStyle(
              fontSize: 12,

              fontWeight: FontWeight.w600,

              color: selected ? const Color(0xffF7931A) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
