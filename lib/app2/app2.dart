import 'package:flutter/material.dart';
import 'pages/food_list_page.dart';

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App 2',
      home: const FoodListPage(), // 👈 จุดสำคัญ
    );
  }
}
