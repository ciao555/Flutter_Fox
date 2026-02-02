import 'package:flutter/material.dart';
import '../widgets/food_item.dart';
import 'cart_page.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("รายการอาหาร"),
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "อาหารคาว",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: const [
                FoodItem(
                  name: "แกงกะหรี่ญี่ปุ่น",
                  img: "assets/images/curry.jpg",
                ),
                FoodItem(name: "ข้าวผัด", img: "assets/images/fried_rice.jpg"),
                FoodItem(name: "ซูชิ", img: "assets/images/sushi.png"),
                FoodItem(name: "ราเมน", img: "assets/images/ramen.png"),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              "ของหวาน",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: const [
                FoodItem(name: "ขนมปังถั่วแดง", img: "assets/images/anpan.jpg"),
                FoodItem(
                  name: "ขนมปังเมลอน",
                  img: "assets/images/melon_pan.jpg",
                ),
                FoodItem(name: "ซอฟต์ครีม", img: "assets/images/soft.png"),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
