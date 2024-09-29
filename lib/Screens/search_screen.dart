import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper/Controller/fetch_api.dart';
import 'package:wallpaper/Models/photo_model.dart';
import 'package:wallpaper/Screens/category_screen.dart';
import 'package:wallpaper/Screens/full_screen.dart';
import 'package:wallpaper/category.dart';
import 'package:wallpaper/myhomepage.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  const SearchScreen({super.key,required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotoModel> searches=[];
  late bool isDone;
  getSearches() async{
    searches= await FetchApi.searchWallpaper(widget.searchQuery);
    setState(() {
      isDone=true;
    });
  }
  @override
  void initState() {
    super.initState();
    isDone=false;
    getSearches();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController=TextEditingController();
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));
          },
        ),
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: TextFormField(
                  onFieldSubmitted: (value)
                  {
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
                      hintText: "${widget.searchQuery}",
                      hintStyle: const TextStyle(color: Colors.black87,fontSize: 18)
                  ),

                ),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.9),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,crossAxisSpacing: 7,mainAxisSpacing: 7
                          ,mainAxisExtent: 400,),
                      itemCount: searches.length, itemBuilder: (context,index)
                  {
                    return InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreen(imgUrl: searches[index].imgSrc,)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24)
                        ),
                        child: Hero(
                          tag: searches[index].imgSrc,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(fit: BoxFit.fill,searches[index].imgSrc),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ):
          const Center(child: CircularProgressIndicator(color: Colors.redAccent,),)
    );
  }
}
