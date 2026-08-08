import 'package:flutter/material.dart';
import 'upgrade_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;

  void openUpgrade() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UpgradeScreen()),
    );
  }

  void showAccountMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 15),

                accountItem(Icons.person_outline, "Edit Your Account", () {
                  Navigator.pop(context);
                  showEditAccount();
                }),

                accountItem(Icons.swap_horiz, "Switch Accounts", () {
                  Navigator.pop(context);
                  showSwitchAccount();
                }),

                accountItem(
                  Icons.workspace_premium_outlined,
                  "Upgrade To Pro",
                  () {
                    Navigator.pop(context);
                    openUpgrade();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget accountItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  void showEditAccount() {
    final nameController = TextEditingController(text: "Ramy");

    final emailController = TextEditingController(text: "ramy@example.co.uk");

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xffFCF8F3),
          title: const Text(
            "Edit Your Account",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
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
                    content: Text("Account updated successfully"),
                    backgroundColor: Colors.green,
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

  void showSwitchAccount() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Switch Accounts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: const AssetImage(
                      "assets/images/profile.png",
                    ),
                  ),
                  title: const Text("Ramy"),
                  subtitle: const Text("ramy@example.co.uk"),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text("Add another account"),
                  onTap: () {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Add account option selected"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showFoodWaste() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xffFCF8F3),
          title: const Text(
            "Food Waste Savings",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Track the food you save and reduce unnecessary food waste.",
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),
                foregroundColor: Colors.black,
              ),
              child: const Text("Got It!"),
            ),
          ],
        );
      },
    );
  }

  void showEatingPreferences() {
    bool vegetarian = false;
    bool glutenFree = false;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xffFCF8F3),
              title: const Text(
                "Eating Preferences",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: const Text("Vegetarian"),
                    value: vegetarian,
                    activeColor: const Color(0xffF7931A),
                    onChanged: (value) {
                      setDialogState(() {
                        vegetarian = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Gluten Free"),
                    value: glutenFree,
                    activeColor: const Color(0xffF7931A),
                    onChanged: (value) {
                      setDialogState(() {
                        glutenFree = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text("Eating preferences saved"),
                        backgroundColor: Colors.green,
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
      },
    );
  }

  void showYourRecipes() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Recipes",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 18),

                const ListTile(
                  leading: Icon(Icons.restaurant_menu),
                  title: Text("No personal recipes yet"),
                  subtitle: Text("Your saved recipes will appear here."),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF7931A),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Done"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void shareMealime() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Share Mealime option selected")),
    );
  }

  void meetOurChefs() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xffFCF8F3),
          title: const Text(
            "Meet Our Chefs",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Discover recipes and cooking inspiration from our chefs.",
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),
                foregroundColor: Colors.black,
              ),
              child: const Text("Explore"),
            ),
          ],
        );
      },
    );
  }

  Widget settingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      body: SafeArea(
        child: Column(
          children: [
            // --------------------------------
            // TOP
            // --------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                children: [
                  // --------------------------------
                  // PROFILE
                  // --------------------------------
                  GestureDetector(
                    onTap: showAccountMenu,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 34,
                              backgroundImage: AssetImage(
                                "assets/images/profile.png",
                              ),
                            ),

                            Positioned(
                              bottom: -4,
                              right: -12,
                              child: Image.asset(
                                "assets/images/free.png",
                                width: 42,
                                height: 24,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "ramy@example.co.uk",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(width: 5),

                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --------------------------------
                  // UPGRADE CARD
                  // --------------------------------
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffffe2bd),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Upgrade to Pro",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Get exclusive recipes, nutritional\n"
                          "information, advanced filters, and more.",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.4,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 14),

                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: openUpgrade,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF7931A),
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Upgrade Now!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // --------------------------------
                  // OPTIONS
                  // --------------------------------
                  settingItem(
                    icon: Icons.savings_outlined,
                    title: "Food Waste Savings",
                    onTap: showFoodWaste,
                  ),

                  settingItem(
                    icon: Icons.tune,
                    title: "Eating Preferences",
                    onTap: showEatingPreferences,
                  ),

                  settingItem(
                    icon: Icons.restaurant_menu_outlined,
                    title: "Your Recipes",
                    onTap: showYourRecipes,
                  ),

                  settingItem(
                    icon: Icons.card_giftcard_outlined,
                    title: "Share Mealime",
                    onTap: shareMealime,
                  ),

                  settingItem(
                    icon: Icons.people_outline,
                    title: "Meet Our Chefs",
                    onTap: meetOurChefs,
                  ),
                ],
              ),
            ),

            // --------------------------------
            // BOTTOM NAVIGATION
            // --------------------------------
            Container(
              height: 78,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xffE6E6E6))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  navItem(
                    icon: Icons.restaurant_menu_outlined,
                    title: "Meal Plan",
                    selected: false,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  navItem(
                    icon: Icons.shopping_basket_outlined,
                    title: "Groceries",
                    selected: false,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  navItem(
                    icon: Icons.favorite_border,
                    title: "Favorites",
                    selected: false,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  navItem(
                    icon: Icons.settings_outlined,
                    title: "Settings",
                    selected: true,
                    onTap: () {},
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
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: selected ? const Color(0xffF7931A) : Colors.grey,
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: selected ? const Color(0xffF7931A) : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
