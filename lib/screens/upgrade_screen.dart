import 'package:flutter/material.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  int selectedImage = 0;

  // ============================================================
  // FOOD IMAGES
  // ============================================================

  final List<String> foodImages = [
    "assets/images/image1.jpg",
    "assets/images/image2.jpg",
    "assets/images/image3.jpg",
    "assets/images/image4.jpg",
  ];

  // ============================================================
  // FOOD DESCRIPTIONS
  // ============================================================

  final List<String> foodDescriptions = [
    "Chicken Breast with cooked Rice and a sticky, Flavorful Sauce",
    "Classic Greek Salad with Feta and Kalamata Olives",
    "Italian Pasta fettuccine Alfredo with Creamy fettuccine Alfredo",
    "Spaghetti with Tomato Sauce, Olives and Basil garnish",
  ];

  // ============================================================
  // NEXT IMAGE
  // ============================================================

  void nextImage() {
    setState(() {
      selectedImage++;

      if (selectedImage >= foodImages.length) {
        selectedImage = 0;
      }
    });
  }

  // ============================================================
  // PREVIOUS IMAGE
  // ============================================================

  void previousImage() {
    setState(() {
      selectedImage--;

      if (selectedImage < 0) {
        selectedImage = foodImages.length - 1;
      }
    });
  }

  // ============================================================
  // SELECT IMAGE FROM DOT
  // ============================================================

  void selectImage(int index) {
    setState(() {
      selectedImage = index;
    });
  }

  // ============================================================
  // UPGRADE BUTTON
  // ============================================================

  void upgradeToPro() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xffFCF8F3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            "Upgrade To Pro",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          content: const Text(
            "Pro features are ready to be activated in your app.",
            style: TextStyle(fontSize: 15, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Pro upgrade selected"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),
                foregroundColor: Colors.black,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // RESTORE PURCHASES
  // ============================================================

  void restorePurchases() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("No previous purchase found.")),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffDDF5E8),
      body: SafeArea(
        child: Stack(
          children: [
            // ==================================================
            // BACKGROUND DECORATIONS
            // ==================================================

            // CARROT - LEFT SIDE
            Positioned(
              left: -35,
              top: screenHeight * 0.23,
              child: Image.asset(
                "assets/images/carrot.png",
                width: 125,
                height: 125,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),

            // BANANA - RIGHT TOP
            Positioned(
              right: -55,
              top: screenHeight * 0.18,
              child: Image.asset(
                "assets/images/banana.png",
                width: 175,
                height: 190,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),

            // FOOD - LEFT BOTTOM
            Positioned(
              left: -45,
              bottom: screenHeight * 0.23,
              child: Image.asset(
                "assets/images/food.png",
                width: 190,
                height: 190,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),

            // STRAWBERRY - RIGHT BOTTOM
            Positioned(
              right: -25,
              bottom: screenHeight * 0.22,
              child: Image.asset(
                "assets/images/strawberry.png",
                width: 135,
                height: 135,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),

            // ==================================================
            // TOP CONTENT
            // ==================================================
            Column(
              children: [
                // CLOSE MAIN SCREEN BUTTON
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, top: 5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // TITLE
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Text(
                    "Unlock Exclusive Recipes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // SUBTITLE
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Access new recipes every month\n"
                    "reserved for pro subscribers.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ==================================================
                // RECIPE CARD
                // ==================================================
                Container(
                  width: 320,
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      // IMAGE
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              foodImages[selectedImage],
                              width: double.infinity,
                              height: 235,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  height: 235,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 42,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Recipe image not found",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // =========================================
                          // PRO + BUTTON
                          // =========================================
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  // PRO
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 17,
                                      vertical: 11,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffDDF5E8),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      "Pro",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff267044),
                                      ),
                                    ),
                                  ),

                                  // PLUS
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 29,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // DESCRIPTION
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          foodDescriptions[selectedImage],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ==================================================
                // NO DOTS HERE
                // ==================================================
                // Pehle yahan dots thay.
                // Ab remove kar diye hain.
              ],
            ),

            // ==================================================
            // BOTTOM WHITE CARD
            // ==================================================
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(25, 16, 25, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ==================================================
                    // CLOSE WHITE CARD
                    // ==================================================
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          // White card ko temporarily hide karne ke liye
                          // neeche wali state use hogi.
                          setState(() {
                            showBottomCard = false;
                          });
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    const SizedBox(height: 2),

                    // ==================================================
                    // ONLY DOTS
                    // ==================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(foodImages.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            selectImage(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: index == selectedImage ? 11 : 9,
                            height: index == selectedImage ? 11 : 9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == selectedImage
                                  ? const Color(0xffF7931A)
                                  : Colors.grey.shade300,
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    // PRICE
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "\$2.99 a month. Cancel anytime.",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // UPGRADE BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: upgradeToPro,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF7931A),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: const Text(
                          "Upgrade To Pro",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // RESTORE PURCHASES
                    TextButton(
                      onPressed: restorePurchases,
                      child: const Text(
                        "Restore Purchases",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WHITE CARD VISIBILITY
  // ============================================================

  bool showBottomCard = true;
}
