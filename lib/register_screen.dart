
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
      appBar: AppBar(
        title: const Text("Smartphone Store"),
        //leading: Icon(Icons.phone_android),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                onTap: (){
                  Navigator.pushNamed(context,"/home");
                },
              ),
              ListTile(
                title: Text("Login"),
                leading: Icon(Icons.person),
                onTap: (){
                  Navigator.pushNamed(context,"/login");
                },
              ),
              ListTile(
                title: Text("Register"),
                leading: Icon(Icons.app_registration),
                onTap: (){
                  Navigator.pushNamed(context,"/register");
                },
              ),

            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(100),
        child: Column(
            children: [
              Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              SizedBox(height: 30,),
              Text("Email"),
              SizedBox(height: 5,),
              TextField(
                controller: _emailController,
              ),
              SizedBox(height: 20,),
              Text("Password"),
              SizedBox(height: 5,),
              TextField(
                controller: _passController,
                obscureText: true,
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                      child: Text("Register"),
                      onPressed: (){
                        setState(() {
                          email = _emailController.text;
                          password=_passController.text;
                        });
                      }),
                ],
              ),
            ]),
      ),
    );
  }
}

