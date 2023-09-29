import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smartphone Store"),
        leading: Icon(Icons.phone_android),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
