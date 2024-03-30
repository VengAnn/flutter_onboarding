import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Screen"),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Home Screen"),
          ),
        ],
      ),
    );
  }
}
