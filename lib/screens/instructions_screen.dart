import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/meal_data.dart';
import 'cookware_screen.dart';
import 'ingredients_screen.dart';
import 'cooking_mode_screen.dart';
import 'notes_screen.dart';
import 'feedback_screen.dart';
import 'collections_screen.dart';

class InstructionsScreen extends StatefulWidget {
  final Meal meal;
  final String notes;

  const InstructionsScreen({super.key, required this.meal, this.notes = ""});

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  bool isCooked = false;
  bool showGroceryGuide = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          showGroceryGuide = true;
        });
      }
    });
  }

  // ------------------------------------------------------------
  // COOKING MODE
  // ------------------------------------------------------------

  void openCookingMode() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CookingModeScreen(meal: widget.meal)),
    );
  }

  // ------------------------------------------------------------
  // FEEDBACK
  // ------------------------------------------------------------

  Future<void> openFeedback() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FeedbackScreen(meal: widget.meal)),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Feedback Received. Thanks!",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 85),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // ------------------------------------------------------------
  // NOTES
  // ------------------------------------------------------------

  void openNotes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NotesScreen(meal: widget.meal)),
    );
  }

  // ------------------------------------------------------------
  // COLLECTIONS
  // ------------------------------------------------------------

  void openCollections() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CollectionsScreen(meal: widget.meal)),
    );
  }

  // ------------------------------------------------------------
  // NUTRITION
  // ------------------------------------------------------------

  void showNutritionFacts() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Nutrition Facts",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),

                nutritionRow("Calories", "420 kcal"),
                nutritionRow("Protein", "28 g"),
                nutritionRow("Carbohydrates", "45 g"),
                nutritionRow("Fat", "14 g"),
                nutritionRow("Fiber", "6 g"),
                nutritionRow("Sugar", "5 g"),
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
          Text(name),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // ACTION MENU
  // ------------------------------------------------------------

  void openActionMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Action Menu",
      barrierColor: Colors.black.withOpacity(.25),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(.08)),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                color: Colors.transparent,
                child: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),

                        Container(
                          width: 45,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        const SizedBox(height: 8),

                        actionItem(Icons.info_outline, "Nutrition Facts", () {
                          Navigator.pop(context);
                          showNutritionFacts();
                        }),

                        actionItem(
                          Icons.timer_outlined,
                          "Open Cooking Mode",
                          () {
                            Navigator.pop(context);
                            openCookingMode();
                          },
                        ),

                        actionItem(Icons.note_alt_outlined, "Add Notes", () {
                          Navigator.pop(context);
                          openNotes();
                        }),

                        actionItem(Icons.share_outlined, "Share", () {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Share option selected"),
                            ),
                          );
                        }),

                        actionItem(Icons.print_outlined, "Print", () {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Print option selected"),
                            ),
                          );
                        }),

                        actionItem(
                          Icons.feedback_outlined,
                          "Feedback For The Chef",
                          () {
                            Navigator.pop(context);
                            openFeedback();
                          },
                        ),

                        actionItem(
                          Icons.collections_bookmark_outlined,
                          "Add To Collections",
                          () {
                            Navigator.pop(context);
                            openCollections();
                          },
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget actionItem(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 20, color: Colors.grey.shade700),
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(height: 1, color: Colors.grey.shade300),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // GROCERY GUIDE POPUP
  // ------------------------------------------------------------

  Widget buildGroceryGuide() {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(.18)),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(18),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Grocery shopping\nmade easy",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showGroceryGuide = false;
                        });
                      },
                      icon: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                const Text("Step 1", style: TextStyle(color: Colors.grey)),

                const Text(
                  "Check off staples you already have.",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                const Text("Step 2", style: TextStyle(color: Colors.grey)),

                const Text(
                  "Add groceries you may need.",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                const Text("Step 3", style: TextStyle(color: Colors.grey)),

                const Text(
                  "Shop easily in-store or online.",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showGroceryGuide = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF7931A),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Got It!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // COOKED
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
  // BOTTOM BAR
  // ------------------------------------------------------------

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
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
                  minimumSize: const Size(0, 52),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                onPressed: openCookingMode,
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
                  style: TextStyle(fontWeight: FontWeight.bold),
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
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // TOP BAR
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 8, 15, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                              IconButton(
                                onPressed: openActionMenu,
                                icon: const Icon(Icons.more_horiz),
                              ),
                            ],
                          ),
                        ),

                        // TABS
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: tabButton("Cookware", false, () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CookwareScreen(meal: widget.meal),
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: tabButton("Ingredients", false, () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          IngredientsScreen(meal: widget.meal),
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: tabButton("Instructions", true, () {}),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // INSTRUCTIONS
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            children: List.generate(
                              widget.meal.instructions.length,
                              (index) {
                                final step = widget.meal.instructions[index];

                                return instructionCard(index + 1, step);
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),

                buildBottomBar(),
              ],
            ),

            if (showGroceryGuide) Positioned.fill(child: buildGroceryGuide()),
          ],
        ),
      ),
    );
  }

  Widget tabButton(String title, bool active, VoidCallback onTap) {
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

  Widget instructionCard(int number, RecipeInstruction instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Text(
              "$number",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instruction.text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),

                if (instruction.ingredients.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: instruction.ingredients
                          .map(
                            (item) => Text(
                              item,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                if (instruction.timerMinutes != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(
                      "${instruction.timerMinutes} minutes",
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
