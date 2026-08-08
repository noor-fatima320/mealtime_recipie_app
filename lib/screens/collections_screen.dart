import 'package:flutter/material.dart';
import '../data/meal_data.dart';
import 'new_collection_screen.dart';

class CollectionsScreen extends StatefulWidget {
  final Meal meal;

  const CollectionsScreen({super.key, required this.meal});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  // ============================================================
  // COLLECTIONS
  // ============================================================

  final List<String> collections = ["Healthy", "Japanese"];

  // ============================================================
  // SELECTED COLLECTIONS
  // ============================================================

  final List<bool> selectedCollections = [true, false];

  // ============================================================
  // OPEN NEW COLLECTION SCREEN
  // ============================================================

  Future<void> openNewCollection() async {
    final String? newCollection = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewCollectionScreen()),
    );

    if (newCollection != null && newCollection.trim().isNotEmpty) {
      setState(() {
        collections.add(newCollection.trim());

        // New collection initially unselected
        selectedCollections.add(false);
      });
    }
  }

  // ============================================================
  // TOGGLE COLLECTION
  // ============================================================

  void toggleCollection(int index, bool? value) {
    setState(() {
      selectedCollections[index] = value ?? false;
    });
  }

  // ============================================================
  // ADD TO FAVORITES
  // ============================================================

  void addToFavorites() {
    // Check whether at least one collection is selected
    final bool hasSelectedCollection = selectedCollections.contains(true);

    if (!hasSelectedCollection) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one collection.")),
      );
      return;
    }

    // Add current meal to favorites
    if (!favoriteMeals.contains(widget.meal)) {
      favoriteMeals.add(widget.meal);
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${widget.meal.title} added to Favorites"),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        backgroundColor: const Color(0xffFCF8F3),
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ==================================================
            // TITLE
            // ==================================================
            const Text(
              "Select collections",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              "Create your own collections for quick access "
              "to all your favorites.",
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // COLLECTION LIST
            // ==================================================
            Expanded(
              child: ListView.builder(
                itemCount: collections.length,

                itemBuilder: (context, index) {
                  final String collection = collections[index];

                  final bool isSelected = selectedCollections[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),

                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xffffe4bd)
                          : Colors.white,

                      borderRadius: BorderRadius.circular(14),

                      border: Border.all(
                        color: isSelected
                            ? const Color(0xffF7931A)
                            : Colors.grey.shade300,
                      ),
                    ),

                    child: ListTile(
                      // =================================================
                      // IMAGE
                      // =================================================
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),

                        child: Image.asset(
                          widget.meal.image,
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // =================================================
                      // COLLECTION NAME
                      // =================================================
                      title: Text(
                        collection,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      // =================================================
                      // RECIPE COUNT
                      // =================================================
                      subtitle: const Text("Recipes"),

                      // =================================================
                      // CHECKBOX
                      // =================================================
                      trailing: Checkbox(
                        value: isSelected,

                        activeColor: const Color(0xffF7931A),

                        onChanged: (value) {
                          toggleCollection(index, value);
                        },
                      ),

                      onTap: () {
                        toggleCollection(index, !isSelected);
                      },
                    ),
                  );
                },
              ),
            ),

            // ==================================================
            // ADD NEW COLLECTION BUTTON
            // ==================================================
            SizedBox(
              width: double.infinity,
              height: 52,

              child: OutlinedButton.icon(
                onPressed: openNewCollection,

                icon: const Icon(Icons.add, color: Colors.grey),

                label: const Text(
                  "Add New Collection",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,

                  side: BorderSide(color: Colors.grey.shade300),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ==================================================
            // ADD BUTTON
            // ==================================================
            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: addToFavorites,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7931A),

                  foregroundColor: Colors.black,

                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: const Text(
                  "Add",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
