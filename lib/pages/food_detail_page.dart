import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../data/food_data.dart';
import '../service/location_service.dart';
import '../service/cart_service.dart';

class FoodDetailPage extends StatefulWidget {
  final String name;

  const FoodDetailPage({
    super.key,
    required this.name,
  });

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  String gpsText = "กำลังหาตำแหน่ง...";
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _loadLocation();
    _initVideo();
  }

  void _initVideo() {
    final food = FoodData.foods[widget.name]!;

    _controller = VideoPlayerController.asset(food["video"])
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadLocation() async {
    try {
      final food = FoodData.foods[widget.name]!;
      final pos = await LocationService.getCurrentLocation();

      final distanceKm = LocationService.distanceKm(
        pos.latitude,
        pos.longitude,
        food["lat"],
        food["lng"],
      );

      setState(() {
        gpsText =
            "📍 พิกัดปัจจุบัน\n"
            "${pos.latitude.toStringAsFixed(5)}, "
            "${pos.longitude.toStringAsFixed(5)}\n\n"
            "📏 ระยะทางถึงร้าน\n"
            "${distanceKm.toStringAsFixed(2)} กม.";
      });
    } catch (e) {
      setState(() {
        gpsText = "ไม่สามารถระบุตำแหน่งได้";
      });
    }
  }

  Future<void> _openMap() async {
    final food = FoodData.foods[widget.name]!;
    final lat = food["lat"];
    final lng = food["lng"];

    final uri = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng",
    );

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final food = FoodData.foods[widget.name]!;

    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎥 วิดีโอ
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            else
              const Center(child: CircularProgressIndicator()),

            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                ),
                const Text("วิดีโอการทำอาหาร"),
              ],
            ),

            const SizedBox(height: 10),
            Text(gpsText),

            const SizedBox(height: 16),
            const Text(
              "🧂 วัตถุดิบ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...food["ingredients"]
                .map<Widget>((i) => Text("• $i")),

            const SizedBox(height: 16),
            const Text(
              "👨‍🍳 วิธีทำ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...food["steps"]
                .map<Widget>((s) => Text("- $s")),

            const SizedBox(height: 24),

            // 🧭 ปุ่มนำทาง
            ElevatedButton.icon(
              onPressed: _openMap,
              icon: const Icon(Icons.navigation),
              label: const Text("นำทางไปยังร้าน"),
            ),

            const SizedBox(height: 12),

            // 🛒 ปุ่มเพิ่มตะกร้า
            ElevatedButton.icon(
              onPressed: () {
                CartService.addItem(widget.name, food["price"]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("เพิ่มลงตะกร้าแล้ว"),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text("เพิ่มลงตะกร้า"),
            ),
          ],
        ),
      ),
    );
  }
}
