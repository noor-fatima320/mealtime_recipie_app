import 'package:flutter/material.dart';

class GrocerySearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> existingItems;

  const GrocerySearchScreen({super.key, required this.existingItems});

  @override
  State<GrocerySearchScreen> createState() => _GrocerySearchScreenState();
}

class _GrocerySearchScreenState extends State<GrocerySearchScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<String> allItems = [
    "bananas",
    "bread",
    "eggs",
    "apples",
    "milk",
    "almond milk",
    "fish",
    "oranges",
    "chicken",
    "rice",
    "tomatoes",
    "potatoes",
    "onions",
    "garlic",
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(allItems);

    searchController.addListener(filterItems);
  }

  void filterItems() {
    final query = searchController.text.toLowerCase();

    setState(() {
      filteredItems = allItems
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  void addItem(String item) {
    Navigator.pop(context, {"name": item, "quantity": "1"});
  }

  void addCustomItem() {
    final text = searchController.text.trim();

    if (text.isEmpty) return;

    Navigator.pop(context, {"name": text, "quantity": "1"});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xffFCF8F3),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 12),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Add something...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            searchController.clear();
                          },
                          icon: const Icon(Icons.close),
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];

                  return InkWell(
                    onTap: () => addItem(item),
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add, color: Colors.grey),
                          const SizedBox(width: 10),
                          Text(item, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (searchController.text.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: addCustomItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF7931A),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: Text(
                      'Add "${searchController.text}"',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
