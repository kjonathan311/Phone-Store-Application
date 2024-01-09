import 'package:flutter/material.dart';
import 'package:phone_store_application/detail_phone_screen.dart';
import 'package:phone_store_application/phone.dart';
import 'package:phone_store_application/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
                              setState((){
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
                                        dataCart.removeQty(index);
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
                          // Navigator.push(context,MaterialPageRoute(builder: (context){
                          //   return DetailScreen(phone:phone);
                          // }));
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
    // final myCart = Provider.of<CartProvider>(context).allcart;
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
                        child: 
                        Consumer<CartProvider>(
                          builder: (context, CartProvider dataCart, widget) => Checkbox(
                            value: cartCheck[index],
                            activeColor: Colors.orangeAccent,
                            onChanged: (newBool){
                              setState((){
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
                                        dataCart.removeQty(index);
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
                          // Navigator.push(context,MaterialPageRoute(builder: (context){
                          //   return DetailScreen(phone:phone);
                          // }));
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


// class _mobilePageMainScreeenState extends State<mobilePageMainScreeen> {
//   String query = '';
//   List<Phone> listPhone = phoneList;

//   @override
//   void initState() {
//     listPhone = phoneList;
//     super.initState();
//   }

//   void onQueryChanged(String newQuery) {
//     setState(() {
//       query = newQuery;
//       listPhone = searchPhone(query);
//     });
    
//   }

//   int _counter = 0;
//   bool _isChecked = false;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   void _decrementCounter() {
//     setState(() {
//       if (_counter>0) {
//         _counter--;
//       }
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // final myCart = Provider.of<CartProvider>(context).allcart;
//     return Column(
//       children: <Widget>[
//         SizedBox(height: 10,),
//         Expanded(
//           flex: 9,
//           child: Padding(
//             padding: EdgeInsets.all(25.0),
//             child: ListView.builder(itemBuilder: (context,index){
//               final Phone phone=listPhone[index];
//               return InkWell(
//                 onTap: (){
//                   Navigator.push(context,MaterialPageRoute(builder: (context){
//                     return DetailScreen(phone:phone);
//                   }));
//                 },
//                 child: Card(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     // children: [
//                     //   Checkbox(value: true,onChanged: (value) => false,),
//                     //   Expanded(child: Image.network(phone.images.first, fit: BoxFit.contain, width: 180, height: 180,)),
//                     //   Expanded(
//                     //     child: Row(
//                     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //       crossAxisAlignment: CrossAxisAlignment.center,
//                     //       children: <Widget>[
//                     //         // Padding(padding: EdgeInsets.all(8),child: Text(phone.name,style: const TextStyle(fontSize: 15.0))),
//                     //         // Padding(padding: EdgeInsets.all(8),child: Text(phone.price,style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))),
//                     //         // Padding(padding: EdgeInsets.all(8),
//                     //         //     child: ElevatedButton(
//                     //         //       style: phone.condition=='Baru'? ElevatedButton.styleFrom(primary: Colors.blueGrey):ElevatedButton.styleFrom(primary: Colors.orange),
//                     //         //       onPressed: (){
//                     //         //       Navigator.push(context,MaterialPageRoute(builder: (context){
//                     //         //         return DetailScreen(phone:phone);
//                     //         //       }));
//                     //         //     },child:Text(phone.condition, style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),

//                     //         //     )
//                     //         // ),
//                     //         Expanded(child: Text(phone.name)),
//                     //         Expanded(child: Text(phone.price))
//                     //       ],
//                     //     )
//                     //   ),
//                     // ],
//                     children :[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                         child: Checkbox(
//                           value: _isChecked,
//                           activeColor: Colors.orangeAccent,
//                           onChanged: (newBool){
//                             setState(() => _isChecked = newBool!);
//                           },
//                         )
//                       ),
//                       Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), child: Image.network(phone.images.first, fit: BoxFit.contain, width: 130, height: 130,)),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Text(phone.name,style: const TextStyle(fontSize: 15.0))),
//                             Padding(padding: EdgeInsets.fromLTRB(0, 19, 0, 0), child: Text(phone.price,style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))),
//                           ]
//                         )
//                       ),
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: 30,
//                               height: 30,
//                               child: FittedBox(
//                                 child: FloatingActionButton(
//                                   onPressed: _decrementCounter,
//                                   backgroundColor: Colors.blue,
//                                   child: Icon(Icons.remove),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 30.0,
//                               child: Text("$_counter",textAlign: TextAlign.center,),  
//                             ),
//                             SizedBox(
//                               width: 30,
//                               height: 30,
//                               child: FittedBox(
//                                 child: FloatingActionButton(
//                                   onPressed: _incrementCounter,
//                                   backgroundColor: Colors.blue,
//                                   child: Icon(Icons.add),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ), 
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },itemCount: listPhone.length,),
//           )
//         ),
//         Padding(
//           padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
//           child : Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text("Total Produk : $_counter",style: TextStyle(fontWeight: FontWeight.bold),),
//                     Text("$_counter")
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(primary: Colors.blue),
//                       onPressed: (){
//                         // Navigator.push(context,MaterialPageRoute(builder: (context){
//                         //   return DetailScreen(phone:phone);
//                         // }));
//                       },child:Text("Checkout", style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),
//                     )
//                   ],
//                 )
//               ],
//             )
//           )
//         )
//       ],
//     );
//   }
// }
