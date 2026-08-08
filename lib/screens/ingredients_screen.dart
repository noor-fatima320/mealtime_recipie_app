import 'package:flutter/material.dart';

import '../data/meal_data.dart';
import 'cookware_screen.dart';
import 'instructions_screen.dart';

class IngredientsScreen extends StatefulWidget {
  final Meal meal;

  const IngredientsScreen({super.key, required this.meal});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  bool isCooked = false;

  // ------------------------------------------------------------
  // Cookware Screen
  // ------------------------------------------------------------

  void openCookware() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => CookwareScreen(meal: widget.meal)),
    );
  }

  // ------------------------------------------------------------
  // Instructions Screen
  // ------------------------------------------------------------

  void openInstructions() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => InstructionsScreen(meal: widget.meal, notes: ""),
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
  // Tab Button
  // ------------------------------------------------------------

  Widget buildTabButton({
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
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
      ),
    );
  }

  // ------------------------------------------------------------
  // Bottom Buttons
  // ------------------------------------------------------------

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
                  size: 18,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // UI
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      body: SafeArea(
        child: Column(
          children: [
            // ----------------------------------------------------
            // Top Bar
            // ----------------------------------------------------
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, size: 22),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: () {
                      // Action menu baad mein yahan connect hoga.
                    },
                    icon: const Icon(Icons.more_horiz, size: 23),
                  ),
                ],
              ),
            ),

            // ----------------------------------------------------
            // Main Content
            // ----------------------------------------------------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------------------------------------------
                    // Tabs
                    // ------------------------------------------------
                    Row(
                      children: [
                        buildTabButton(
                          title: "Cookware",
                          active: false,
                          onTap: openCookware,
                        ),

                        const SizedBox(width: 8),

                        buildTabButton(
                          title: "Ingredients",
                          active: true,
                          onTap: () {},
                        ),

                        const SizedBox(width: 8),

                        buildTabButton(
                          title: "Instructions",
                          active: false,
                          onTap: openInstructions,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // ------------------------------------------------
                    // Ingredients
                    // ------------------------------------------------
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.meal.ingredients.length,
                      itemBuilder: (context, index) {
                        final ingredient = widget.meal.ingredients[index];

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Ingredient name
                              Expanded(
                                child: Text(
                                  ingredient.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              // Quantity
                              Text(
                                ingredient.quantity,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ----------------------------------------------------
            // Fixed Bottom Bar
            // ----------------------------------------------------
            buildBottomBar(),
          ],
        ),
      ),
    );
  }
}
