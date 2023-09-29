import 'package:flutter/material.dart';
import 'package:phone_store_application/phone.dart';

class DetailScreen extends StatelessWidget {
  final Phone phone;
  const DetailScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context,BoxConstraints contraints){
      if(contraints.maxWidth>800){
        return webPageDetailScreen(phone:phone);
      }else{
        return mobilePageDetailScreen(phone:phone);
      }
    });
  }
}


class webPageDetailScreen extends StatefulWidget {
  final Phone phone;
  const webPageDetailScreen({super.key, required this.phone});

  @override
  State<webPageDetailScreen> createState() => _webPageDetailScreenState();
}

class _webPageDetailScreenState extends State<webPageDetailScreen> {
  final _scrollController = ScrollController();
  int image_index=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); },),
      ),
      body: Center(
        child:
        Container(
          margin:EdgeInsets.symmetric(horizontal: 64) ,
            child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child:Column(
                    children: [
                      SelectedImage(image: widget.phone.images[image_index]),
                      const SizedBox(height: 20),
                      Scrollbar(
                          controller: _scrollController,
                          child:Container(
                              height: 150,
                              child:ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.symmetric(horizontal:10),
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.phone.images.length,
                                itemBuilder: (BuildContext context,int index){
                                  String image=widget.phone.images[index];
                                  return InkWell(
                                    onTap: (){
                                      setState(() {
                                        image_index=index;
                                      });
                                    },
                                    child: Image.network(image),
                                  );
                                }
                              )
                          )
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child:
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Padding(
                          padding: EdgeInsets.all(12),
                          child:  Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 7),
                                child:Text(widget.phone.name,style: TextStyle(fontSize: 15.0)) ,
                              ),
                              Container(
                                height: 13,
                                margin: EdgeInsets.only(bottom: 10),
                                child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: int.parse(widget.phone.rating),itemBuilder: (context,index){
                                  return Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.yellow,
                                  );
                                }),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child:Text(widget.phone.price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),) ,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 7),
                                child:Text(widget.phone.description) ,
                              ),
                            ],
                          ),
                    )
                  )
                )
              ],
          )
        )

      ),
    );
  }
}

class mobilePageDetailScreen extends StatefulWidget {
  final Phone phone;
  const mobilePageDetailScreen({super.key, required this.phone});

  @override
  State<mobilePageDetailScreen> createState() => _mobilePageDetailScreenState();
}


class _mobilePageDetailScreenState extends State<mobilePageDetailScreen> {
  final _scrollController = ScrollController();
  int image_index=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); },),
      ),
      body:SingleChildScrollView(child:
      Center(
          child:
          Container(
              margin:EdgeInsets.symmetric(horizontal: 64) ,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child:Column(
                      children: [
                        SelectedImage(image: widget.phone.images[image_index]),
                        const SizedBox(height: 20),
                        Scrollbar(
                            controller: _scrollController,
                            child:Container(
                                height: 150,
                                child:ListView.builder(
                                    controller: _scrollController,
                                    padding: const EdgeInsets.symmetric(horizontal:10),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.phone.images.length,
                                    itemBuilder: (BuildContext context,int index){
                                      String image=widget.phone.images[index];
                                      return InkWell(
                                        onTap: (){
                                          setState(() {
                                            image_index=index;
                                          });
                                        },
                                        child: Image.network(image),
                                      );
                                    }
                                )
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                      child:
                      Card(
                          margin: EdgeInsets.symmetric(vertical: 25),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child:  Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child:Text(widget.phone.name,style: TextStyle(fontSize: 15.0)) ,
                                ),
                                Container(
                                  height: 13,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: int.parse(widget.phone.rating),itemBuilder: (context,index){
                                    return Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.yellow,
                                    );
                                  }),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child:Text(widget.phone.price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),) ,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child:Text(widget.phone.description) ,
                                ),
                              ],
                            ),
                          )
                      )
                  )
                ],
              )
          )

      ),
    )
    );
  }
}



class SelectedImage extends StatefulWidget {
  final String image;

  SelectedImage({required this.image});

  @override
  State<SelectedImage> createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
          child: Image.network(widget.image,fit: BoxFit.contain),
          borderRadius: BorderRadius.circular(10),
        ),

    );
  }
}