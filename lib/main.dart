import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'app1/app1.dart';
import 'app2/app2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เลือกแอพ')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text('App 1'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const App1()),
              );
            },
          ),
          ElevatedButton(
            child: const Text('App 2'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const App2()),
              );
            },
          ),
        ],
      ),
    );
  }
}
