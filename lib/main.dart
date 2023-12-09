import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_application/login_screen.dart';
import 'package:phone_store_application/main_screen.dart';
import 'package:phone_store_application/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp>_initialization=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error initializing Firebase: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Smartphone Store',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: "/home",
            routes: {
              "/home": (context) => const MainScreen(),
              "/login": (context) => const LoginScreen(),
              "/register": (context) => const RegisterScreen(),
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

}
