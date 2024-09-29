import 'dart:convert';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/Controller/fetch_api.dart';
import 'package:wallpaper/Screens/category_screen.dart';
import 'package:wallpaper/Screens/search_screen.dart';
import 'package:wallpaper/category.dart';

import 'Models/photo_model.dart';
import 'Screens/full_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List <String>name=[
    "Cars",
    "Flowers",
    "Bikes",
    "Love",
    "Nature",
    "City",
    "Dark",
    "Pet",
    "Street"
  ];

  getRandom(List list)
  {
    List<String> shuffledList = name;
    shuffledList.shuffle(Random());
    return shuffledList;
  }
  late List<PhotoModel> wallpaper;
  late bool isLoad;
  late List <String>catName;
  getTrends()async {
    wallpaper=await FetchApi.getWallpaper();
    setState(() {
      isLoad=true;
    });
  }
  @override
  void initState() {
    super.initState();
    getTrends();
    catName=getRandom(name);
    isLoad=false;
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController=TextEditingController();
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: RichText(
            text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(text: "Wall ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30)),
                  TextSpan(text: "Wizard",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 30)),
                ]
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoad? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: TextFormField(
                  onFieldSubmitted: (value){
                    if(value==null||value==" "){
                      Fluttertoast.showToast(
                          msg: "Search Results cannot be null",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  SearchScreen(searchQuery: searchController.text,)));
                    }

                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: (){
                        if(searchController.text==null||searchController.text==" "){
                          Fluttertoast.showToast(
                              msg: "Search Results cannot be null",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                        else
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  SearchScreen(searchQuery: searchController.text,)));
                        }
                      },
                    ),
                    focusedBorder:const OutlineInputBorder(
                        borderRadius:BorderRadius.all(Radius.circular(50))),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    hintText: "  Search Wallpapers",
                    hintStyle: const TextStyle(color: Colors.black87,fontSize: 18)
                  ),

                ),
              ),
            ),
            Container(
              height: 108,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(itemBuilder: (context,index)
              {
                return InkWell(borderRadius: BorderRadius.circular(20),
                    onTap: ()
                    {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen(catName: catName[index],)));
                 },
                   child: Category(catName: catName[index],));
                },itemCount: name.length,
              scrollDirection: Axis.horizontal,),
            ),
              const SizedBox(height: 20,),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.9),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(physics: const BouncingScrollPhysics(),gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,crossAxisSpacing: 7,mainAxisSpacing: 7,mainAxisExtent: 400),
                          itemCount: wallpaper.length,
                          itemBuilder: (context,index)
                       {
                        return InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreen(imgUrl: wallpaper[index].imgSrc,)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24)
                            ),
                            child: Hero(
                              tag: wallpaper[index].imgSrc,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child:  Image.network(fit: BoxFit.fill,wallpaper[index].imgSrc),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
              ),


          ],
        ):const Center(child: CircularProgressIndicator(color: Colors.redAccent,),)
    );
  }
}
