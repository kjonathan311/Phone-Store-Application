import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_application/FIrebaseAuthService.dart';
import 'package:phone_store_application/provider/cart_provider.dart';
import 'package:provider/provider.dart';

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
    final allCart = Provider.of<CartProvider>(context, listen: false);

    final FirebaseAuthService _auth = FirebaseAuthService();

      User? user = await _auth.Login(email,password);
      if (user != null) {
        showToast(message: "User successfully login");
        allCart.initialData(email).then((value){
          Navigator.pushNamed(context, "/home");
        });
      }
  }

  @override
  Widget build(BuildContext context){
    final allCart = Provider.of<CartProvider>(context, listen: false);
    String userNow = "";
    User? statusUser = FirebaseAuth.instance.currentUser;
    if(statusUser!=null){
      userNow = statusUser.email.toString();
    }
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
              ListTile(
                title: Text("Cart"),
                leading: Icon(Icons.add_shopping_cart_rounded),
                onTap: (){
                  if (allCart.isInitialdata == false && userNow!=""){
                    allCart.initialData(userNow).then((value){
                      Navigator.pushNamed(context,"/cart");
                    });
                  }
                  else{
                    Navigator.pushNamed(context,"/cart");
                  }
                },
              ),

            ],
          ),
          ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(100),
            child: Column(
            children: [
            Text("Sign In",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
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
            Row(
              children: [
                FloatingActionButton(onPressed: (){
                  
                })
              ],
            )
          ]),
            ),
        ),
    );
  }
}


