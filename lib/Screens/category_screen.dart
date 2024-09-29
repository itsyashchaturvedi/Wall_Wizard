import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/Controller/fetch_api.dart';
import 'package:wallpaper/category.dart';

import '../Models/photo_model.dart';
import 'full_screen.dart';

class CategoryScreen extends StatefulWidget {
  String catName;
  CategoryScreen({super.key,required this.catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotoModel> catItems;
  late bool isDone;
  getImages() async{
    catItems=await FetchApi.searchWallpaper(widget.catName);
    setState(() {
      isDone=true;
    });

  }
  @override
  void initState() {
    super.initState();
    isDone=false;
    getImages();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(40.0),
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
      body: isDone?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children:[
                SizedBox(
                  height: 168,
                  width: MediaQuery.of(context).size.width,
                   child: Image.asset("assets/background.webp",fit: BoxFit.cover,)
                 ),
                 Container(
                  height: 168,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black45
                  ),
                ),
                SizedBox(
                  height: 168,
                    width: MediaQuery.of(context).size.width,
                    child:  Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            const Text("Category",
                              style: TextStyle(color: Colors.white,fontSize: 13),),
                            Text(widget.catName,
                              style: const TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      )
                    )
                )
              ]
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.9),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(itemCount: catItems.length,
                      physics: const BouncingScrollPhysics(),gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 7,mainAxisSpacing: 7,mainAxisExtent: 400), itemBuilder: (context,index)
                  {
                    return InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreen(imgUrl: catItems[index].imgSrc,)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24)
                        ),
                        child: Hero(
                          tag: catItems[index].imgSrc,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(fit: BoxFit.fill,catItems[index].imgSrc),
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
