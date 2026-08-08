import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/meal_data.dart';
import 'meal_detail_screen.dart';
import 'meal_search_screen.dart';

class SelectMealPlanScreen extends StatefulWidget {
  const SelectMealPlanScreen({super.key});

  @override
  State<SelectMealPlanScreen> createState() => _SelectMealPlanScreenState();
}

class _SelectMealPlanScreenState extends State<SelectMealPlanScreen> {
  bool showGuide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),
      body: Stack(
        children: [buildMainScreen(), if (showGuide) buildGuidePopup()],
      ),
    );
  }

  // ============================================================
  // MAIN SCREEN
  // ============================================================

  Widget buildMainScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // TOP BAR
              // ==================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MealSearchScreen(meals: allMeals),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ==================================================
              // TITLE
              // ==================================================
              const Text(
                "Build a meal plan",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // MOST POPULAR
              // ==================================================
              buildHeading("Most Popular", mostPopularMeals),

              const SizedBox(height: 20),

              buildMealSection(mostPopularMeals),

              const SizedBox(height: 35),

              // ==================================================
              // RECENTLY CREATED
              // ==================================================
              buildHeading("Recently Created", recentMeals),

              const SizedBox(height: 20),

              buildMealSection(recentMeals),

              const SizedBox(height: 35),

              // ==================================================
              // RECOMMENDED PLAN
              // ==================================================
              buildHeading("Recommended Plan", recommendedMeals),

              const SizedBox(height: 20),

              buildMealSection(recommendedMeals),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADING + SEE ALL
  // ============================================================

  Widget buildHeading(String title, List meals) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MealCategoryScreen(title: title, meals: meals),
              ),
            );
          },
          child: const Text(
            "See All",
            style: TextStyle(
              color: Color(0xffF7931A),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // GUIDE POPUP
  // ============================================================

  Widget buildGuidePopup() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Container(
        color: Colors.black.withOpacity(.15),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(18),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==================================================
                // TOP ROW
                // ==================================================
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Build your first meal plan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showGuide = false;
                        });
                      },
                      child: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  "Add a few recipes to cook this week,\n"
                  "and we'll build you an easy-to-shop\n"
                  "grocery list.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showGuide = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF7931A),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Got It!",
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
      ),
    );
  }

  // ============================================================
  // MEAL HORIZONTAL SECTION
  // ============================================================

  Widget buildMealSection(List meals) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: meals.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),

        itemBuilder: (context, index) {
          final meal = meals[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MealDetailScreen(meal: meal)),
              );
            },

            child: SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==================================================
                  // IMAGE
                  // ==================================================
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          meal.image,
                          height: 120,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // ==================================================
                      // PLUS BUTTON
                      // ==================================================
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                if (!favoriteMeals.contains(meal)) {
                                  favoriteMeals.add(meal);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${meal.title} added to Favorites",
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                }
                              });
                            },
                            icon: const Icon(Icons.add, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ==================================================
                  // TITLE
                  // ==================================================
                  Text(
                    meal.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================================================================
// ALL MEALS
// ================================================================
//
// Search ke liye teeno categories ko combine kiya gaya hai.
// Agar kisi recipe ka title kisi bhi category mein hai,
// search usko find kar lega.
//

final List allMeals = [
  ...mostPopularMeals,
  ...recentMeals,
  ...recommendedMeals,
];

// ================================================================
// CATEGORY SCREEN
// ================================================================

class MealCategoryScreen extends StatelessWidget {
  final String title;
  final List meals;

  const MealCategoryScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF8F3),
        elevation: 0,
        foregroundColor: Colors.black,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),

        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(18),

        itemCount: meals.length,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          childAspectRatio: 0.72,
        ),

        itemBuilder: (context, index) {
          final meal = meals[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MealDetailScreen(meal: meal)),
              );
            },

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    meal.image,
                    width: double.infinity,
                    height: 145,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 9),

                // TITLE
                Text(
                  meal.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
