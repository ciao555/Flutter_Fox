import 'package:flutter/material.dart';
import 'pages/food_list_page.dart';

class App1Entry extends StatelessWidget {
  const App1Entry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fox Food',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF7A00),
      ),
      home: const FoodListPage(),
    );
  }
}
