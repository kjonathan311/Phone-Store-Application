import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_application/detail_phone_screen.dart';
import 'package:phone_store_application/phone.dart';
import 'package:phone_store_application/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  print(userNow);
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
    String userNow = "";
    User? statusUser = FirebaseAuth.instance.currentUser;
    if(statusUser!=null){
      userNow = statusUser.email.toString();
    }
    return Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Expanded(
              flex: 1,
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  onSubmitted: onQueryChanged,
                  decoration: InputDecoration(
                    hintText: 'Search Other Phone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search)),
                  ),
              )
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: EdgeInsets.all(25.0),
                    child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children:
                          listPhone.map((phone){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return DetailScreen(phone:phone);
                                }));
                              },
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                        child:Image.network(
                                            phone.images.first,
                                          fit: BoxFit.fill,
                                        )
                                    ),
                                    const SizedBox(height: 15),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 3),
                                          child: Text(phone.name,style: const TextStyle(fontSize: 15.0),) ,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(phone.price,style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),textAlign: TextAlign.left) ,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                style: phone.condition=='Baru'? ElevatedButton.styleFrom(primary: Colors.blueGrey):ElevatedButton.styleFrom(primary: Colors.orange),
                                                onPressed: (){
                                                  Navigator.push(context,MaterialPageRoute(builder: (context){
                                                    return DetailScreen(phone:phone);
                                                  }));
                                                },child:Text(phone.condition, style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),
                                              ),
                                              Consumer<CartProvider>(
                                                builder: (context, CartProvider dataCart, widget) => ElevatedButton(
                                                  style: ElevatedButton.styleFrom(primary: Colors.cyan),
                                                  onPressed: ()async{
                                                    setState(() {
                                                      dataCart.addCart(phone, userNow, context);
                                                    });
                                                  }, 
                                                  child:Icon(Icons.add_shopping_cart_rounded, color: Colors.black,)
                                                )
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ), 
            ),

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
    String userNow = "";
    User? statusUser = FirebaseAuth.instance.currentUser;
    if(statusUser!=null){
      userNow = statusUser.email.toString();
    }
    return Column(
      children: <Widget>[
         SizedBox(height: 10,),
         Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  onSubmitted: onQueryChanged,
                  decoration: InputDecoration(
                    hintText: 'Search Other Phone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search)),
                  ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: ListView.builder(itemBuilder: (context,index){
                  final Phone phone=listPhone[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context){
                        return DetailScreen(phone:phone);
                      }));
                    },
                    child: Card(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: Image.network(phone.images.first)),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.all(8),child: Text(phone.name,style: const TextStyle(fontSize: 15.0))),
                                  Padding(padding: EdgeInsets.all(8),child: Text(phone.price,style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          style: phone.condition=='Baru'? ElevatedButton.styleFrom(primary: Colors.blueGrey):ElevatedButton.styleFrom(primary: Colors.orange),
                                          onPressed: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context){
                                              return DetailScreen(phone:phone);
                                            }));
                                          },child:Text(phone.condition, style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),
                                        ),
                                        // ElevatedButton(
                                        //   style: ElevatedButton.styleFrom(primary: Colors.blue),
                                        //   onPressed: (){
                                        //     Navigator.push(context,MaterialPageRoute(builder: (context){
                                        //       // return DetailScreen(phone:phone);
                                        //       return Consumer<CartProvider>(
                                        //         builder:(context, CartProvider dataCart, widget) {
                                        //           setState(() {
                                        //             dataCart.addCart(phone);
                                        //           });
                                        //         },
                                        //       );
                                        //     }));
                                        //   },child:Icon(Icons.add_shopping_cart_rounded, color: Colors.black,),
                                        // ),
                                        Consumer<CartProvider>(
                                          builder: (context, CartProvider dataCart, widget) => ElevatedButton(
                                            style: ElevatedButton.styleFrom(primary: Colors.cyan),
                                            onPressed: ()async{
                                               dataCart.addCart(phone, userNow, context);
                                            }, 
                                            child:Icon(Icons.add_shopping_cart_rounded, color: Colors.black,)
                                          )
                                        )
                                      ],
                                    ),
                                  )
                                  // Padding(padding: EdgeInsets.all(8),
                                  //     child: ElevatedButton(
                                  //       style: phone.condition=='Baru'? ElevatedButton.styleFrom(primary: Colors.blueGrey):ElevatedButton.styleFrom(primary: Colors.orange),
                                  //       onPressed: (){
                                  //       Navigator.push(context,MaterialPageRoute(builder: (context){
                                  //         return DetailScreen(phone:phone);
                                  //       }));
                                  //     },child:Text(phone.condition, style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),

                                  //     )),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },itemCount: listPhone.length,),
            )
            ),
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
  
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//          SizedBox(height: 10,),
//          Expanded(
//               flex: 1,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 25),
//                 child: TextField(
//                   onSubmitted: onQueryChanged,
//                   decoration: InputDecoration(
//                     hintText: 'Search Other Phone',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.search)),
//                   ),
//               ),
//             ),
//             Expanded(
//               flex: 9,
//               child: Padding(
//                 padding: EdgeInsets.all(25.0),
//                 child: ListView.builder(itemBuilder: (context,index){
//                   final Phone phone=listPhone[index];
//                   return InkWell(
//                     onTap: (){
//                       Navigator.push(context,MaterialPageRoute(builder: (context){
//                         return DetailScreen(phone:phone);
//                       }));
//                     },
//                     child: Card(
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Expanded(child: Image.network(phone.images.first)),
//                           Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(padding: EdgeInsets.all(8),child: Text(phone.name,style: const TextStyle(fontSize: 15.0))),
//                                   Padding(padding: EdgeInsets.all(8),child: Text(phone.price,style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold))),
//                                   Padding(
//                                     padding: EdgeInsets.all(8),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         ElevatedButton(
//                                           style: phone.condition=='Baru'? ElevatedButton.styleFrom(primary: Colors.blueGrey):ElevatedButton.styleFrom(primary: Colors.orange),
//                                           onPressed: (){
//                                             Navigator.push(context,MaterialPageRoute(builder: (context){
//                                               return DetailScreen(phone:phone);
//                                             }));
//                                           },child:Text(phone.condition, style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),
//                                         ),
//                                         ElevatedButton(
//                                           style: ElevatedButton.styleFrom(primary: Colors.blue),
//                                           onPressed: (){
//                                             Navigator.push(context,MaterialPageRoute(builder: (context){
//                                               return DetailScreen(phone:phone);
//                                             }));
//                                           },child:Icon(Icons.add_shopping_cart_rounded, color: Colors.black,),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                   // Padding(padding: EdgeInsets.all(8),
//                                   //     child: ElevatedButton(
//                                   //       style: phone.condition=='Baru'? ElevatedButton.styleFrom(primary: Colors.blueGrey):ElevatedButton.styleFrom(primary: Colors.orange),
//                                   //       onPressed: (){
//                                   //       Navigator.push(context,MaterialPageRoute(builder: (context){
//                                   //         return DetailScreen(phone:phone);
//                                   //       }));
//                                   //     },child:Text(phone.condition, style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),

//                                   //     )),
//                                 ],
//                               )
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },itemCount: listPhone.length,),
//             )
//             ),
//       ],
//     );
//   }
// }
