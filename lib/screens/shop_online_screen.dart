import 'package:flutter/material.dart';

class ShopOnlineScreen extends StatefulWidget {
  const ShopOnlineScreen({super.key});

  @override
  State<ShopOnlineScreen> createState() => _ShopOnlineScreenState();
}

class _ShopOnlineScreenState extends State<ShopOnlineScreen> {
  bool showShortcut = true;

  final List<Map<String, dynamic>> stores = [
    {"name": "Asda", "image": "assets/images/store1.png"},
    {"name": "Ocado", "image": "assets/images/store2.png"},
    {"name": "Tesco", "image": "assets/images/store3.png"},
  ];

  // ------------------------------------------------------------
  // STORE CLICK
  // ------------------------------------------------------------

  void openStore(String storeName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$storeName selected",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xff3FA66B),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ------------------------------------------------------------
  // SHOW ALL STORES
  // ------------------------------------------------------------

  void showAllStores() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xffFCF8F3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "All Stores",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),

                const SizedBox(height: 18),

                ...stores.map(
                  (store) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),

                    leading: Image.asset(
                      store["image"],
                      width: 45,
                      height: 45,
                      fit: BoxFit.contain,
                    ),

                    title: Text(
                      store["name"],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    trailing: const Icon(Icons.arrow_forward_ios, size: 17),

                    onTap: () {
                      Navigator.pop(context);
                      openStore(store["name"]);
                    },
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // FEEDBACK
  // ------------------------------------------------------------

  void giveFeedback() {
    final controller = TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xffFCF8F3),

          title: const Text(
            "Give us feedback",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),

          content: TextField(
            controller: controller,
            maxLines: 4,

            style: const TextStyle(fontSize: 15),

            decoration: InputDecoration(
              hintText: "Tell us what you think...",

              hintStyle: TextStyle(color: Colors.grey.shade600),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Thanks for your feedback!",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: Color(0xff3FA66B),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF7931A),
                foregroundColor: Colors.black,
              ),

              child: const Text(
                "Send",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),

      appBar: AppBar(
        backgroundColor: const Color(0xffFCF8F3),

        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.close, color: Colors.black, size: 25),
        ),

        title: const Text(
          "Shop Online",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Divider(color: Color(0xffDDDDDD)),

              const SizedBox(height: 5),

              // ------------------------------------------------
              // STORES
              // ------------------------------------------------
              ...stores.map(
                (store) => buildStoreItem(store["name"], store["image"]),
              ),

              const SizedBox(height: 8),

              const Text(
                "Only showing stores available in your country.",
                style: TextStyle(
                  color: Color(0xff555555),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 15),

              // ------------------------------------------------
              // SHOW ALL STORES
              // ------------------------------------------------
              SizedBox(
                width: double.infinity,
                height: 48,

                child: OutlinedButton(
                  onPressed: showAllStores,

                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,

                    side: const BorderSide(color: Color(0xffCCCCCC)),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: const Text(
                    "Show All Stores",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // SETTINGS
              // ------------------------------------------------
              const Text(
                "Settings",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),

              const SizedBox(height: 8),

              const Text(
                "Access online shopping options quickly "
                "with a shortcut button on your grocery list.",
                style: TextStyle(
                  color: Color(0xff666666),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Checkbox(
                    value: showShortcut,

                    activeColor: const Color(0xffF7931A),

                    onChanged: (value) {
                      setState(() {
                        showShortcut = value ?? false;
                      });
                    },
                  ),

                  const Expanded(
                    child: Text(
                      "Show online shopping shortcut",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // FEEDBACK
              // ------------------------------------------------
              const Center(
                child: Text(
                  "How can we make online shopping better\nfor you?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: TextButton.icon(
                  onPressed: giveFeedback,

                  icon: const Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                    size: 19,
                    color: Color(0xff555555),
                  ),

                  label: const Text(
                    "Give us feedback",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // STORE ITEM
  // ============================================================

  Widget buildStoreItem(String name, String image) {
    return InkWell(
      onTap: () => openStore(name),

      child: Container(
        height: 76,

        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffDDDDDD))),
        ),

        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,

              padding: const EdgeInsets.all(5),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xffDDDDDD)),
              ),

              child: Image.asset(image, fit: BoxFit.contain),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xff555555),
            ),
          ],
        ),
      ),
    );
  }
}
