import 'package:flutter/material.dart';
import '../widgets/food_item.dart';
import 'cart_page.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🦊 Fox Food"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            const Text(
              "อาหารคาว",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
              children: const [
                FoodItem(name: "ข้าวมันไก่", imagePath: "assets/images/munkai.jpg"),
                FoodItem(name: "หมูทอด", imagePath: "assets/images/mutod.jpg"),
                FoodItem(name: "ผัดมาม่า", imagePath: "assets/images/pad.jpg"),
                FoodItem(name: "ไก่ทอด", imagePath: "assets/images/chicken.jpg"),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              "ของหวาน",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
              children: const [
                FoodItem(name: "ข้าวเหนียวมะม่วง", imagePath: "assets/images/mango.jpg"),
                FoodItem(name: "บัวลอย", imagePath: "assets/images/buo.jpg"),
                FoodItem(name: "ข้าวเหนียวสังขยา", imagePath: "assets/images/Kaonuy.jpg"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
