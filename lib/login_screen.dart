import 'package:flutter/material.dart';
import 'package:phone_store_application/User.dart';

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

  Future<void> _handleLogin() async {
    email = _emailController.text;
    password = _passController.text;

    final user = await loginUser(email: email, password: password);

    setState(() {
      if (user != null) {
        _showSnackBar(context, "Success Login");
        Navigator.pushNamed(context, "/home");
      } else {
        _showSnackBar(context, "Error Login");
      }
    });
  }

  @override
  Widget build(BuildContext context){
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
                title: Text("Home"),
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
          Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
                child: Text("Login"),
                onPressed: ()async{
                    await _handleLogin();
              }),
            ],
          ),
        ]),
          ),
    );
  }
}

void _showSnackBar(BuildContext context,String text) {
  final snackBar = SnackBar(
    content: Text(text),
    duration: Duration(seconds: 3),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}