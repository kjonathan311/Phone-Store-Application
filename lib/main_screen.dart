import 'package:flutter/material.dart';
import 'package:phone_store_application/detail_phone_screen.dart';
import 'package:phone_store_application/phone.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smartphone Store"),
        leading: Icon(Icons.phone_android),
        backgroundColor: Colors.blueGrey,
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


class webPageMainScreen extends StatelessWidget {
  const webPageMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(25.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children:
          phoneList.map((phone){
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
                        Padding(padding: EdgeInsets.all(8),
                            child: ElevatedButton(
                              style: phone.condition=='Baru'? ElevatedButton.styleFrom(primary: Colors.blueGrey):ElevatedButton.styleFrom(primary: Colors.orange),
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return DetailScreen(phone:phone);
                                }));
                              },child:Text(phone.condition, style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),

                            )),
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
    );
  }
}

class mobilePageMainScreeen extends StatelessWidget {
  const mobilePageMainScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(25.0),
        child: ListView.builder(itemBuilder: (context,index){
          final Phone phone=phoneList[index];
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
                          Padding(padding: EdgeInsets.all(8),
                              child: ElevatedButton(
                                style: phone.condition=='Baru'? ElevatedButton.styleFrom(primary: Colors.blueGrey):ElevatedButton.styleFrom(primary: Colors.orange),
                                onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return DetailScreen(phone:phone);
                                }));
                              },child:Text(phone.condition, style:const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black)),

                              )),
                        ],
                      )
                  ),
                ],
              ),
            ),
          );
        },itemCount: phoneList.length,),
    );
  }
}
