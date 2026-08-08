import 'package:flutter/material.dart';

import '../data/meal_data.dart';

import 'ingredients_screen.dart';
import 'instructions_screen.dart';
import 'cookware_screen.dart';
import 'feedback_screen.dart';
import 'collections_screen.dart';

class MealDetailScreen extends StatefulWidget {
  final Meal meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  bool isFavorite = false;
  bool isCooked = false;

  @override
  void initState() {
    super.initState();

    isFavorite = favoriteMeals.contains(widget.meal);
  }

  // ------------------------------------------------------------
  // Open Ingredients Screen
  // ------------------------------------------------------------

  void openIngredients() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => IngredientsScreen(meal: widget.meal)),
    );
  }

  // ------------------------------------------------------------
  // Open Instructions / Cooking Screen
  // ------------------------------------------------------------

  void openInstructions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InstructionsScreen(meal: widget.meal, notes: ""),
      ),
    );
  }

  // ------------------------------------------------------------
  // Open Cookware Screen
  // ------------------------------------------------------------

  void openCookware() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CookwareScreen(meal: widget.meal)),
    );
  }

  // ------------------------------------------------------------
  // Favorite
  // ------------------------------------------------------------

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;

      if (isFavorite) {
        if (!favoriteMeals.contains(widget.meal)) {
          favoriteMeals.add(widget.meal);
        }
      } else {
        favoriteMeals.remove(widget.meal);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? "${widget.meal.title} added to Favorites"
              : "${widget.meal.title} removed from Favorites",
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ------------------------------------------------------------
  // Cooked Button
  // ------------------------------------------------------------

  void toggleCooked() {
    setState(() {
      isCooked = !isCooked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCooked ? "Recipe marked as cooked" : "Recipe marked as not cooked",
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ------------------------------------------------------------
  // Add Notes Dialog
  // ------------------------------------------------------------

  void openNotesDialog() {
    final TextEditingController notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xffFCF8F3),

          title: const Text(
            "Add Notes",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          content: TextField(
            controller: notesController,
            maxLines: 5,

            decoration: InputDecoration(
              hintText: "Write your note...",
              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Note saved successfully"),
                    duration: Duration(seconds: 1),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),
                foregroundColor: Colors.black,
              ),

              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // Nutrition Facts
  // ------------------------------------------------------------

  void showNutritionFacts() {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Nutrition Facts",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),

                const Divider(),

                const SizedBox(height: 10),

                nutritionRow("Calories", "420 kcal"),
                nutritionRow("Protein", "28 g"),
                nutritionRow("Carbohydrates", "45 g"),
                nutritionRow("Fat", "14 g"),
                nutritionRow("Fiber", "6 g"),
                nutritionRow("Sugar", "5 g"),

                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget nutritionRow(String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(name, style: const TextStyle(fontSize: 16)),

          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Action Menu
  // ------------------------------------------------------------

  void openActionMenu() {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              const SizedBox(height: 10),

              Container(
                width: 45,
                height: 5,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 15),

              actionMenuItem(
                icon: Icons.info_outline,
                title: "Nutrition Facts",

                onTap: () {
                  Navigator.pop(context);
                  showNutritionFacts();
                },
              ),

              actionMenuItem(
                icon: Icons.timer_outlined,
                title: "Open Cooking Mode",

                onTap: () {
                  Navigator.pop(context);
                  openInstructions();
                },
              ),

              actionMenuItem(
                icon: Icons.note_alt_outlined,
                title: "Add Notes",

                onTap: () {
                  Navigator.pop(context);
                  openNotesDialog();
                },
              ),

              actionMenuItem(
                icon: Icons.share_outlined,
                title: "Share",

                onTap: () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Share option opened")),
                  );
                },
              ),

              actionMenuItem(
                icon: Icons.print_outlined,
                title: "Print",

                onTap: () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Print option selected")),
                  );
                },
              ),

              actionMenuItem(
                icon: Icons.feedback_outlined,
                title: "Feedback For The Chef",

                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedbackScreen(meal: widget.meal),
                    ),
                  );
                },
              ),

              actionMenuItem(
                icon: Icons.collections_bookmark_outlined,
                title: "Add To Collections",

                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CollectionsScreen(meal: widget.meal),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  Widget actionMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),

      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),

      trailing: const Icon(Icons.chevron_right, size: 20),

      onTap: onTap,
    );
  }

  // ------------------------------------------------------------
  // Bottom Button
  // ------------------------------------------------------------

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),

      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),

      child: SafeArea(
        top: false,

        child: Row(
          children: [
            // Cooked
            Expanded(
              child: OutlinedButton.icon(
                onPressed: toggleCooked,

                icon: Icon(
                  isCooked ? Icons.check_circle : Icons.radio_button_unchecked,

                  color: isCooked ? Colors.green : Colors.grey,
                ),

                label: Text(isCooked ? "Cooked" : "Cooked?"),

                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,

                  side: BorderSide(color: Colors.grey.shade300),

                  minimumSize: const Size(0, 52),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Start Cooking
            Expanded(
              child: ElevatedButton(
                onPressed: openInstructions,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7931A),

                  foregroundColor: Colors.black,

                  elevation: 0,

                  minimumSize: const Size(0, 52),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                child: const Text(
                  "Start Cooking",

                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Main UI
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      body: SafeArea(
        child: Column(
          children: [
            // -------------------------------------------------
            // Scrollable Content
            // -------------------------------------------------
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // -------------------------------------------------
                    // Image
                    // -------------------------------------------------
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),

                          child: Image.asset(
                            widget.meal.image,

                            width: double.infinity,

                            height: 310,

                            fit: BoxFit.cover,
                          ),
                        ),

                        // Back
                        Positioned(
                          top: 15,
                          left: 15,

                          child: CircleAvatar(
                            backgroundColor: Colors.white,

                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),

                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),

                        // Three dots
                        Positioned(
                          top: 15,
                          right: 15,

                          child: CircleAvatar(
                            backgroundColor: Colors.white,

                            child: IconButton(
                              icon: const Icon(Icons.more_horiz),

                              onPressed: openActionMenu,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // -------------------------------------------------
                    // Details
                    // -------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // Title + Favorite
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Expanded(
                                child: Text(
                                  widget.meal.title,

                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    height: 1.15,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              IconButton(
                                onPressed: toggleFavorite,

                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,

                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 7),

                          // Time + servings
                          const Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: Colors.grey,
                              ),

                              SizedBox(width: 5),

                              Text(
                                "35 minutes",
                                style: TextStyle(color: Colors.grey),
                              ),

                              SizedBox(width: 15),

                              Icon(
                                Icons.people_outline,
                                size: 17,
                                color: Colors.grey,
                              ),

                              SizedBox(width: 5),

                              Text(
                                "2 servings",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // -------------------------------------------------
                          // Tabs
                          // -------------------------------------------------
                          Row(
                            children: [
                              Expanded(
                                child: tabButton(
                                  title: "Cookware",
                                  active: true,
                                  onTap: () {
                                    // Cookware is already
                                    // displayed on this screen.
                                  },
                                ),
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: tabButton(
                                  title: "Ingredients",
                                  active: false,
                                  onTap: openIngredients,
                                ),
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: tabButton(
                                  title: "Instructions",
                                  active: false,
                                  onTap: openInstructions,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // -------------------------------------------------
                          // Cookware
                          // -------------------------------------------------
                          const Text(
                            "can opener",

                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Divider(color: Colors.grey.shade300),

                          const SizedBox(height: 10),

                          const Text(
                            "Make sure you have the required cookware before starting this recipe.",

                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // -------------------------------------------------
            // Fixed Bottom Buttons
            // -------------------------------------------------
            buildBottomBar(),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Tab Button
  // ------------------------------------------------------------

  Widget tabButton({
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 42,

        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: active ? const Color(0xffFFF2E3) : Colors.white,

          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color: active ? const Color(0xffF7931A) : Colors.grey.shade300,
          ),
        ),

        child: Text(
          title,

          style: TextStyle(
            fontSize: 12,

            fontWeight: FontWeight.w600,

            color: active ? const Color(0xffF7931A) : Colors.black,
          ),
        ),
      ),
    );
  }
}
