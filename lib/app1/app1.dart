import 'package:flutter/material.dart';
import 'pages/food_list_page.dart';

class App1 extends StatelessWidget {
  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App 1',
      home: const FoodListPage(), // 👈 จุดสำคัญ
    );
  }
}
