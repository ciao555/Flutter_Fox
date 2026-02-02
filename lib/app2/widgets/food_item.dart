import 'package:flutter/material.dart';
import '../pages/food_detail_page.dart';
import '../data/cart.dart';
import '../data/food_data.dart';

class FoodItem extends StatefulWidget {
  final String name;
  final String img;

  const FoodItem({required this.name, required this.img, super.key});

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              widget.img,
              width: 100,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 4),
          Text(
            widget.name,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),
          SizedBox(
            height: 28,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FoodDetailPage(name: widget.name),
                  ),
                );
              },
              child: const Text("กดดู", style: TextStyle(fontSize: 10)),
            ),
          ),

          const SizedBox(height: 4),
          SizedBox(
            height: 26,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.zero,
              ),
              onPressed: () async {
                final food = FoodData.foods[widget.name]!;
                final price = food['price'];

                await Cart.addItem(widget.name, price);
                await Cart.loadCartFromFirebase();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("เพิ่ม ${widget.name} ลงตะกร้าแล้ว"),
                    duration: const Duration(milliseconds: 800),
                  ),
                );

                setState(() {});
              },
              child: const Text("ใส่ตะกร้า", style: TextStyle(fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }
}
