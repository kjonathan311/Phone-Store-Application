import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_application/detail_phone_screen.dart';
import 'package:phone_store_application/phone.dart';
import 'package:phone_store_application/provider/cart_provider.dart';
import 'package:phone_store_application/services/payment.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint(statusUser);
    // final _auth = FirebaseAuth.instance;
    // String userEmail;
    // void getCurrentUserEmail() async {
    // final user =
    //   await _auth.currentUser().then((value) => userEmail = value.email);
    // }
    // final _auth = FirebaseAuth.instance;
    // dynamic user;
    // String userEmail;
    // String userPhoneNumber;

    // void getCurrentUserInfo() async {
    //   user = await _auth.currentUser();
    //   userEmail = user.email;
    //   userPhoneNumber = user.phoneNumber;
    // }
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
                  Navigator.pushNamed(context,"/cart");
                },
              ),

            ],
          ),
          ),
      ),

      body: LayoutBuilder(builder: (BuildContext context,BoxConstraints constraints){
        if(constraints.maxWidth<=1200){
          return mobilePageMainScreeen();
        }else{
          return webPageMainScreen();
        }
      }
      ),
    );
  }
}


class webPageMainScreen extends StatefulWidget {
  const webPageMainScreen({super.key});

  @override
  State<webPageMainScreen> createState() => _webPageMainScreenState();
}

class _webPageMainScreenState extends State<webPageMainScreen> {
  String query = '';
  List<Phone> listPhone = phoneList;

  @override
  void initState() {
    listPhone = phoneList;
    super.initState();
  }

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
      listPhone = searchPhone(query);
    });
    
  }



  @override
  Widget build(BuildContext context) {
    
    PaymentStripe _paymentService = PaymentStripe();

    final cartData = Provider.of<CartProvider>(context, listen:false).allcart;
    final cartQty = Provider.of<CartProvider>(context, listen:false).qty;
    final cartCheck = Provider.of<CartProvider>(context, listen:false).isCheck;
    final checkCount = Provider.of<CartProvider>(context, listen:false).countCheck;
    final totalHarga = Provider.of<CartProvider>(context, listen:false).totalHarga;
    return Column(
      children: <Widget>[
        SizedBox(height: 10,),
        Expanded(
          flex: 9,
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: ListView.builder(itemBuilder: (context,index){
              // final Phone phone=listPhone[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return DetailScreen(phone:cartData[index]);
                  }));
                },
                child: Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children :[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Consumer<CartProvider>(
                          builder: (context, CartProvider dataCart, widget) => Checkbox(
                            value: cartCheck[index],
                            activeColor: Colors.orangeAccent,
                            onChanged: (newBool){
                              setState(() {
                                dataCart.checkAction(index);
                              });
                            },
                          )
                        )
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), child: Image.network(cartData[index].images.first, fit: BoxFit.contain, width: 130, height: 130,)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text(cartData[index].name,style: const TextStyle(fontSize: 15.0))),
                            Padding(padding: EdgeInsets.fromLTRB(0, 19, 0, 0), child: Text(cartData[index].price,style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))),
                          ]
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: FittedBox(
                                child: Consumer<CartProvider>(
                                  builder: (context, CartProvider dataCart, widget) => FloatingActionButton(
                                    heroTag: null,
                                    onPressed: ()async{
                                      setState(() {
                                        dataCart.removeQty(index, context);
                                      });
                                    },
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.remove),
                                  )
                                )
                              ),
                            ),
                            SizedBox(
                              width: 30.0,
                              child: Text(cartQty[index].toString(),textAlign: TextAlign.center,),  
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: FittedBox(
                                child: Consumer<CartProvider>(
                                  builder: (context, CartProvider dataCart, widget) => FloatingActionButton(
                                    heroTag: null,
                                    onPressed: ()async{
                                      setState(() {
                                        dataCart.addQty(index);
                                      });
                                    },
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.add),
                                  )
                                )
                              ),
                            ),
                          ],
                        ), 
                      )
                    ],
                  ),
                ),
              );
            },itemCount: cartData.length,),
          )
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
          child : Container(
            color: Colors.red,
            child: 
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Total Produk : $checkCount",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 5),child : Text("$totalHarga", style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold))),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                        onPressed: (){
                          
                        },child:Text("Checkout", style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),
                      )
                    ],
                  )
                ],
              ),
            )
          )
        )
      ],
    );
  }
}

class mobilePageMainScreeen extends StatefulWidget {
  const mobilePageMainScreeen({super.key});

  @override
  State<mobilePageMainScreeen> createState() => _mobilePageMainScreeenState();
}

class _mobilePageMainScreeenState extends State<mobilePageMainScreeen> {
  String query = '';
  List<Phone> listPhone = phoneList;

  @override
  void initState() {
    listPhone = phoneList;
    super.initState();
  }

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
      listPhone = searchPhone(query);
    });
    
  }

  
  @override
  Widget build(BuildContext context) {
    PaymentStripe _paymentService = PaymentStripe();
    // final myCart = Provider.of<CartProvider>(context).allcart;
    final cartData = Provider.of<CartProvider>(context, listen:false).allcart;
    final cartQty = Provider.of<CartProvider>(context, listen:false).qty;
    final cartCheck = Provider.of<CartProvider>(context, listen:false).isCheck;
    final checkCount = Provider.of<CartProvider>(context, listen:false).countCheck;
    final totalHarga = Provider.of<CartProvider>(context, listen:false).totalHarga;
    final dtotalHarga = Provider.of<CartProvider>(context, listen:false).dtotalHarga;
    if(cartData.length == 0){
      return Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.shopping_cart, size: 60,),
          Text("Tidak ada Barang", style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold))
        ]),
      );
    }   
    else{
      return Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: ListView.builder(itemBuilder: (context,index){
                // final Phone phone=listPhone[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return DetailScreen(phone:cartData[index]);
                    }));
                  },
                  child: Card(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children :[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: 
                          Consumer<CartProvider>(
                            builder: (context, CartProvider dataCart, widget) => Checkbox(
                              value: cartCheck[index],
                              activeColor: Colors.orangeAccent,
                              onChanged: (newBool) async{
                                setState(() {
                                  dataCart.checkAction(index);
                                });
                              },
                            )
                          )
                          
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), child: Image.network(cartData[index].images.first, fit: BoxFit.contain, width: 130, height: 130,)),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text(cartData[index].name,style: const TextStyle(fontSize: 15.0))),
                              Padding(padding: EdgeInsets.fromLTRB(0, 19, 0, 0), child: Text(cartData[index].price,style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))),
                            ]
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: FittedBox(
                                  child : Consumer<CartProvider>(
                                    builder: (context, CartProvider dataCart, widget) => FloatingActionButton(
                                      heroTag: null,
                                      onPressed: ()async{
                                        setState(() {
                                          dataCart.removeQty(index, context);
                                        });
                                      },
                                      backgroundColor: Colors.blue,
                                      child: Icon(Icons.remove),
                                    )
                                  )
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                                child: Text(cartQty[index].toString(),textAlign: TextAlign.center,),  
                              ),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: FittedBox(
                                  child: Consumer<CartProvider>(
                                    builder: (context, CartProvider dataCart, widget) => FloatingActionButton(
                                      heroTag: null,
                                      onPressed: ()async{
                                        setState(() {
                                          dataCart.addQty(index);
                                        });
                                      },
                                      backgroundColor: Colors.blue,
                                      child: Icon(Icons.add),
                                    )
                                  )
                                ),
                              ),
                            ],
                          ), 
                        )
                      ],
                    ),
                  ),
                );
              },itemCount: cartData.length,),
            )
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child : Container(
              color: Colors.red,
              child: 
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("Total Produk : $checkCount",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(right: 5),child : Text("$totalHarga", style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold))),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          onPressed: (){
                            _paymentService.makePayment(context, dtotalHarga);
                          },child:Text("Checkout", style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),
                        )
                      ],
                    )
                  ],
                ),
              )
            )
          )
        ],
      );
    }
  }
}


