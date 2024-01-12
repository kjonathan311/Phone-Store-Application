import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_application/apikeys/apikeys.dart';
import 'package:phone_store_application/UserLogin.dart';
import 'package:phone_store_application/cart_screen.dart';
import 'package:phone_store_application/login_screen.dart';
import 'package:phone_store_application/main_screen.dart';
import 'package:phone_store_application/provider/cart_provider.dart';
import 'package:phone_store_application/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'firebase_options.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = APIkeys.publishableKey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
         options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String? emailLogin =  FirebaseAuth.instance.currentUser?.email.toString();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserLogin userLogin ;
    if (emailLogin != null) {
      userLogin = UserLogin(emailLogin);
    }

    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
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
          "/cart": (context) => const CartScreen(),
        },
      ),
    );
  }
}