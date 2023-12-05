import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String email="";
  String password="";
  @override
  void initState(){
    super.initState();
    _emailController.text=email;
    _passController.text = password;
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          
          Text("Email"),
          SizedBox(height: 5,),
          TextField(
            controller: _emailController,
          ),
          SizedBox(height: 7,),
          Text("Password"),
          SizedBox(height: 5,),
          TextField(
            controller: _passController,
            obscureText: true,
          ),
          FloatingActionButton(
            child: Text("Login"),
            onPressed: (){
            email = _emailController.text;
            password=_passController.text;
          })
        ]),
    );
  }
}