import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  static Map<String, int> items = {};
  static final _db = FirebaseFirestore.instance;

  static Future<void> addItem(String name, int price) async {
    final ref = _db.collection('cart').doc(name);

    int newQty = 1;

    await _db.runTransaction((tx) async {
      final snap = await tx.get(ref);
      newQty = snap.exists ? snap['qty'] + 1 : 1;

      tx.set(ref, {
        'name': name,
        'price': price,
        'qty': newQty,
        'total': price * newQty,
        'status': 'cart',
        'timestamp': FieldValue.serverTimestamp(),
      });
    });

    items[name] = newQty;

    // DEBUG
    print("🛒 Cart.items หลัง addItem = $items");
  }

  static Future<void> removeItem(String name, int price) async {
    final ref = _db.collection('cart').doc(name);

    await _db.runTransaction((tx) async {
      final snap = await tx.get(ref);
      if (!snap.exists) return;

      final qty = snap['qty'];

      if (qty > 1) {
        tx.update(ref, {'qty': qty - 1, 'total': price * (qty - 1)});
        items[name] = qty - 1;
      } else {
        tx.delete(ref);
        items.remove(name);
      }
    });

    // DEBUG
    print("🛒 Cart.items หลัง removeItem = $items");
  }

  static Future<void> loadCartFromFirebase() async {
    final snapshot = await _db.collection('cart').get();
    items.clear();

    for (var doc in snapshot.docs) {
      items[doc.id] = doc['qty'];
    }
  }

  static double getTotalPrice(Map foods) {
    double total = 0;
    items.forEach((name, qty) {
      total += foods[name]["price"] * qty;
    });
    return total;
  }
}
