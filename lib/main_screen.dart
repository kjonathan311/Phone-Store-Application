import 'package:flutter/material.dart';
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
        if(constraints.maxWidth<=800){
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

              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                        child:Image.network(
                            phone.images.first,
                        )
                    ),
                    const SizedBox(height: 15),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Text(phone.name,style: const TextStyle(fontSize: 12.0),) ,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(phone.price,style: const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),textAlign: TextAlign.left) ,
                    ),
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
                          Padding(padding: EdgeInsets.all(8),child: Text(phone.name,style: const TextStyle(fontSize: 12.0))),
                          Padding(padding: EdgeInsets.all(8),child: Text(phone.price,style: const TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold))),
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
