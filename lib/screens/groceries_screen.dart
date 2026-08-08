import 'package:flutter/material.dart';

import 'grocery_search_screen.dart';
import 'shop_online_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import 'select_meal_plan_screen.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  bool showAllergenWarning = true;

  final List<Map<String, dynamic>> groceries = [
    {"name": "lemon", "quantity": "½", "checked": true},
    {"name": "lime", "quantity": "1", "checked": false},
    {"name": "mango", "quantity": "½", "checked": false},
    {"name": "orange", "quantity": "½", "checked": false},
    {"name": "english cucumber", "quantity": "1", "checked": true},
  ];

  // ------------------------------------------------------------
  // TOGGLE GROCERY ITEM
  // ------------------------------------------------------------

  void toggleItem(int index) {
    setState(() {
      groceries[index]["checked"] = !groceries[index]["checked"];
    });
  }

  // ------------------------------------------------------------
  // OPEN SEARCH
  // ------------------------------------------------------------

  Future<void> openSearch() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GrocerySearchScreen(existingItems: groceries),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        groceries.add({
          "name": result["name"],
          "quantity": result["quantity"] ?? "1",
          "checked": false,
        });
      });
    }
  }

  // ------------------------------------------------------------
  // SHOP ONLINE
  // ------------------------------------------------------------

  void openShopOnline() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ShopOnlineScreen()),
    );
  }

  // ------------------------------------------------------------
  // BOTTOM NAVIGATION
  // ------------------------------------------------------------

  void openMealPlan() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SelectMealPlanScreen()),
    );
  }

  void openFavorites() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const FavoritesScreen()),
    );
  }

  void openSettings() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      // --------------------------------------------------------
      // APP BAR
      // --------------------------------------------------------
      appBar: AppBar(
        backgroundColor: const Color(0xffFCF8F3),
        elevation: 0,
        automaticallyImplyLeading: false,

        title: const Text(
          "Groceries",
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),

        actions: [
          IconButton(
            onPressed: openSearch,
            icon: const Icon(Icons.add, color: Colors.black, size: 30),
          ),

          const SizedBox(width: 8),
        ],
      ),

      // --------------------------------------------------------
      // BODY
      // --------------------------------------------------------
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),

          children: [
            // --------------------------------------------------
            // ALLERGEN WARNING
            // --------------------------------------------------
            if (showAllergenWarning) ...[
              buildAllergenWarning(),
              const SizedBox(height: 25),
            ],

            // --------------------------------------------------
            // PRODUCE
            // --------------------------------------------------
            const Text(
              "Produce",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 5),

            // --------------------------------------------------
            // GROCERY ITEMS
            // --------------------------------------------------
            ...List.generate(
              groceries.length,
              (index) => buildGroceryItem(index),
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // SHOP ONLINE BUTTON
            // --------------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 57,
              child: ElevatedButton(
                onPressed: openShopOnline,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7931A),
                  foregroundColor: Colors.black,
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                child: const Text(
                  "Shop Online",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),

      // --------------------------------------------------------
      // BOTTOM NAVIGATION
      // --------------------------------------------------------
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  // ============================================================
  // ALLERGEN WARNING
  // ============================================================

  Widget buildAllergenWarning() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),

      decoration: BoxDecoration(
        color: const Color(0xffED5B4A),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Allergen Warning",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Ingredients with a ⚠ symbol may contain "
            "allergens. Tap an ingredient for more "
            "details, and make sure to purchase an "
            "allergen-free variety.",
            style: TextStyle(color: Colors.white, fontSize: 15, height: 1.45),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 56,

            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showAllergenWarning = false;
                });
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              child: const Text(
                "Got It!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GROCERY ITEM
  // ============================================================

  Widget buildGroceryItem(int index) {
    final item = groceries[index];

    final bool checked = item["checked"] == true;

    return InkWell(
      onTap: () => toggleItem(index),

      child: Container(
        height: 69,

        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),

        child: Row(
          children: [
            // CHECKBOX
            SizedBox(
              width: 32,
              height: 32,

              child: Checkbox(
                value: checked,

                activeColor: const Color(0xffF7931A),

                side: BorderSide(color: Colors.grey.shade400, width: 1.2),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),

                onChanged: (_) {
                  toggleItem(index);
                },
              ),
            ),

            const SizedBox(width: 3),

            // NAME
            Expanded(
              child: Text(
                item["name"],

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,

                  color: checked ? Colors.grey.shade500 : Colors.black,

                  decoration: checked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),

            // QUANTITY
            Text(
              item["quantity"],

              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            ),

            const SizedBox(width: 2),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION BAR
  // ============================================================

  Widget buildBottomNavigationBar() {
    return Container(
      height: 86,

      decoration: const BoxDecoration(
        color: Colors.white,

        border: Border(top: BorderSide(color: Color(0xffE8E8E8), width: 1)),
      ),

      child: SafeArea(
        top: false,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            // MEAL PLAN
            navItem(
              image: "assets/icons/mealplan.png",
              title: "Meal Plan",
              selected: false,
              onTap: openMealPlan,
            ),

            // GROCERIES
            navItem(
              image: "assets/icons/groceries.png",
              title: "Groceries",
              selected: true,
              showBadge: true,
              onTap: () {},
            ),

            // FAVORITES
            navItem(
              image: "assets/icons/favorite.png",
              title: "Favorites",
              selected: false,
              onTap: openFavorites,
            ),

            // SETTINGS
            navItem(
              image: "assets/icons/settings.png",
              title: "Settings",
              selected: false,
              onTap: openSettings,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NAV ITEM
  // ============================================================

  Widget navItem({
    required String image,
    required String title,
    required bool selected,
    required VoidCallback onTap,
    bool showBadge = false,
  }) {
    final Color selectedColor = const Color(0xffF7931A);

    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(12),

      child: SizedBox(
        width: 75,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // ICON + BADGE
            Stack(
              clipBehavior: Clip.none,

              children: [
                Image.asset(
                  image,

                  width: 27,
                  height: 27,

                  color: selected ? selectedColor : Colors.grey.shade400,
                ),

                if (showBadge)
                  Positioned(
                    right: -11,
                    top: -8,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xff3FA66B),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Text(
                        "24",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 5),

            // TITLE
            Text(
              title,

              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,

                color: selected ? selectedColor : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
