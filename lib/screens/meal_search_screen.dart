import 'package:flutter/material.dart';

import 'meal_detail_screen.dart';

class MealSearchScreen extends StatefulWidget {
  final List meals;

  const MealSearchScreen({super.key, required this.meals});

  @override
  State<MealSearchScreen> createState() => _MealSearchScreenState();
}

class _MealSearchScreenState extends State<MealSearchScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // SEARCH
  // ============================================================

  List get filteredMeals {
    if (searchText.trim().isEmpty) {
      return widget.meals;
    }

    return widget.meals.where((meal) {
      return meal.title.toString().toLowerCase().contains(
        searchText.toLowerCase().trim(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = filteredMeals;

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

        title: const Text(
          "Search Recipes",
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: Column(
        children: [
          // ======================================================
          // SEARCH FIELD
          // ======================================================
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 5, 18, 15),
            child: TextField(
              controller: searchController,

              autofocus: true,

              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },

              decoration: InputDecoration(
                hintText: "Search recipes...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),

                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();

                          setState(() {
                            searchText = "";
                          });
                        },
                        icon: const Icon(Icons.close),
                      )
                    : null,

                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xffF7931A),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          // ======================================================
          // RESULTS
          // ======================================================
          Expanded(
            child: results.isEmpty
                ? buildNoResults()
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(18, 5, 18, 20),

                    itemCount: results.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.72,
                        ),

                    itemBuilder: (context, index) {
                      final meal = results[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MealDetailScreen(meal: meal),
                            ),
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
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NO RESULTS
  // ============================================================

  Widget buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 60, color: Colors.grey.shade400),

            const SizedBox(height: 15),

            const Text(
              "No recipes found",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 8),

            Text(
              "Try searching with a different recipe name.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
