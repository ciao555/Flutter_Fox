import 'package:flutter/material.dart';
import 'pages/food_list_page.dart';

class App2Entry extends StatelessWidget {
  const App2Entry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const FoodListPage(),
    );
  }
}
