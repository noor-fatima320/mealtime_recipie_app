import 'package:flutter/material.dart';
import '../data/meal_data.dart';
import 'meal_detail_screen.dart';
import 'home_screen.dart';
import 'groceries_screen.dart';
import 'settings_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF8F3),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,

        title: const Text(
          "Favorites",
          style: TextStyle(
            color: Colors.black,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: favoriteMeals.isEmpty
          ? const Center(
              child: Text(
                "No Favorite Meals Yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: favoriteMeals.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                mainAxisSpacing: 20,

                crossAxisSpacing: 15,

                childAspectRatio: .70,
              ),

              itemBuilder: (context, index) {
                final meal = favoriteMeals[index];

                return buildFavoriteCard(meal);
              },
            ),
      bottomNavigationBar: Container(
        height: 85,

        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xffE5E5E5))),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            navItem(
              image: "assets/icons/mealplan.png",
              title: "Meal Plan",
              selected: false,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
            ),

            navItem(
              image: "assets/icons/groceries.png",
              title: "Groceries",
              selected: false,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const GroceriesScreen()),
                );
              },
            ),

            navItem(
              image: "assets/icons/favorite.png",
              title: "Favorites",
              selected: true,
              onTap: () {},
            ),

            navItem(
              image: "assets/icons/settings.png",
              title: "Settings",
              selected: false,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFavoriteCard(Meal meal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MealDetailScreen(meal: meal)),
        ).then((_) {
          setState(() {});
        });
      },

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //--------------------------------
          // Image + Heart
          //--------------------------------
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),

                child: Image.asset(
                  meal.image,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 10,
                right: 10,

                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      favoriteMeals.remove(meal);
                    });
                  },

                  child: Container(
                    padding: const EdgeInsets.all(8),

                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          //--------------------------------
          // Title
          //--------------------------------
          Text(
            meal.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
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
