import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_application/login_screen.dart';
import 'package:phone_store_application/main_screen.dart';
import 'package:phone_store_application/register_screen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDFB8Kyh32nEH-98SuUgWJl59mEuuMtw20",
          authDomain: "phone-store-project.firebaseapp.com",
          databaseURL: "https://phone-store-project-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "phone-store-project",
          storageBucket: "phone-store-project.appspot.com",
          messagingSenderId: "254618248942",
          appId: "1:254618248942:web:1ae6cbe99b92d7632eb5ff",
          measurementId: "G-HDGP8JJT1N"
      )
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
}