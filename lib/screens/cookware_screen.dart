import 'package:flutter/material.dart';
import '../data/meal_data.dart';
import 'notes_screen.dart';

class CookwareScreen extends StatelessWidget {
  final Meal meal;

  const CookwareScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF8F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Cookware",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              meal.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),
            const Text(
              "Required Cookware",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.check_circle, color: Color(0xffF7931A)),
                    title: Text("Non-stick Frying Pan"),
                  ),

                  ListTile(
                    leading: Icon(Icons.check_circle, color: Color(0xffF7931A)),
                    title: Text("Cooking Pot"),
                  ),

                  ListTile(
                    leading: Icon(Icons.check_circle, color: Color(0xffF7931A)),
                    title: Text("Chef Knife"),
                  ),

                  ListTile(
                    leading: Icon(Icons.check_circle, color: Color(0xffF7931A)),
                    title: Text("Cutting Board"),
                  ),

                  ListTile(
                    leading: Icon(Icons.check_circle, color: Color(0xffF7931A)),
                    title: Text("Mixing Bowl"),
                  ),

                  ListTile(
                    leading: Icon(Icons.check_circle, color: Color(0xffF7931A)),
                    title: Text("Wooden Spoon"),
                  ),

                  ListTile(
                    leading: Icon(Icons.check_circle, color: Color(0xffF7931A)),
                    title: Text("Measuring Cups"),
                  ),

                  ListTile(
                    leading: Icon(Icons.check_circle, color: Color(0xffF7931A)),
                    title: Text("Serving Plate"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NotesScreen(meal: meal)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF7931A),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
