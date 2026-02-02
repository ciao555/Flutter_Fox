import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/food_data.dart';
import 'video_page.dart';
import '../data/cart.dart';

class FoodDetailPage extends StatefulWidget {
  final String name;
  const FoodDetailPage({super.key, required this.name});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  double? userLat;
  double? userLng;
  double? distanceKm;

  Future<void> openGoogleMap(double lat, double lng) async {
    final uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _loadLocation(double shopLat, double shopLng) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      userLat = pos.latitude;
      userLng = pos.longitude;
      distanceKm =
          Geolocator.distanceBetween(userLat!, userLng!, shopLat, shopLng) /
          1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    final detail = FoodData.foods[widget.name]!;

    final double shopLat = detail["shopLat"];
    final double shopLng = detail["shopLng"];

    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "วัตถุดิบ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              ...detail["ingredients"].map<Widget>((e) => Text("• $e")),

              const SizedBox(height: 20),
              const Text(
                "วิธีทำ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              ...detail["steps"].asMap().entries.map<Widget>(
                (e) => Text("${e.key + 1}. ${e.value}"),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () => _loadLocation(shopLat, shopLng),
                icon: const Icon(Icons.location_searching),
                label: const Text("คำนวณระยะทางจากร้าน"),
              ),

              if (userLat != null) ...[
                const SizedBox(height: 10),
                Text("📍 พิกัดร้าน: $shopLat , $shopLng"),
                Text("📡 พิกัดคุณ: $userLat , $userLng"),
                Text(
                  "📏 ระยะทาง: ${distanceKm!.toStringAsFixed(2)} กม.",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ElevatedButton.icon(
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text("เพิ่มลงตะกร้า"),
                  onPressed: () async {
                    final price = detail['price'];

                    await Cart.addItem(widget.name, price);
                    await Cart.loadCartFromFirebase();

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("เพิ่มสินค้าแล้ว")),
                    );
                  },
                ),

                ElevatedButton.icon(
                  onPressed: () => openGoogleMap(shopLat, shopLng),
                  icon: const Icon(Icons.map),
                  label: const Text("ดูตำแหน่งร้านใน Google Maps"),
                ),
              ],

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            VideoPage(videoPath: detail["videoAsset"]),
                      ),
                    );
                  },
                  child: const Text("🎥 ดูวิดีโอสอนทำอาหาร"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
