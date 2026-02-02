import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/food_data.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartRef = FirebaseFirestore.instance.collection('cart');

    return Scaffold(
      appBar: AppBar(title: const Text("ตะกร้าสินค้า")),
      body: StreamBuilder<QuerySnapshot>(
        // ⭐ แสดงเฉพาะของที่ยังอยู่ในตะกร้า
        stream: cartRef.where('status', isEqualTo: 'cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("ยังไม่มีสินค้าในตะกร้า"));
          }

          final docs = snapshot.data!.docs;
          double total = 0;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: docs.map((doc) {
                    final name = doc.id;
                    final data = doc.data() as Map<String, dynamic>;
                    final qty = data['qty'] ?? 1;

                    final food = FoodData.foods[name];
                    if (food == null) return const SizedBox();

                    final price = food['price'] as int;
                    total += price * qty;

                    return ListTile(
                      title: Text(name),
                      subtitle: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () async {
                              if (qty > 1) {
                                await doc.reference.update({'qty': qty - 1});
                              } else {
                                await doc.reference.delete();
                              }
                            },
                          ),
                          Text("$qty", style: const TextStyle(fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () async {
                              await doc.reference.update({'qty': qty + 1});
                            },
                          ),
                        ],
                      ),
                      trailing: Text("${price * qty} บาท"),
                    );
                  }).toList(),
                ),
              ),

              // ===== รวมราคา =====
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "รวมทั้งหมด: $total บาท",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // ===== ปุ่มสั่งซื้อ =====
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      final snapshot = await cartRef
                          .where('status', isEqualTo: 'cart')
                          .get();

                      final batch = FirebaseFirestore.instance.batch();

                      for (var doc in snapshot.docs) {
                        batch.update(doc.reference, {
                          'status': 'ordered',
                          'orderedAt': FieldValue.serverTimestamp(),
                        });
                      }

                      await batch.commit();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("สั่งซื้อเรียบร้อยแล้ว")),
                      );
                    },
                    child: const Text(
                      "สั่งซื้อ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
