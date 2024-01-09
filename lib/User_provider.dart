import 'package:flutter/material.dart';
import 'package:phone_store_application/UserLogin.dart';

class UserProvider extends ChangeNotifier {
   final UserLogin _login = new UserLogin("", "");

   UserLogin get login =>_login;

   void doLogin(String email, String username){
      _login.email = email;
      _login.username = username;
      notifyListeners();
   }

   void doLogout(){
      _login.email = '';
      _login.username = '';
      notifyListeners();
   }

}