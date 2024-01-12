import 'package:flutter/material.dart';
import 'package:phone_store_application/UserLogin.dart';

class UserProvider extends ChangeNotifier {
   final UserLogin _login = new UserLogin('');

   UserLogin get login =>_login;

   void doLogin(String email){
      _login.email = email;
      notifyListeners();
   }

   void doLogout(){
      _login.email = '';
      notifyListeners();
   }

}