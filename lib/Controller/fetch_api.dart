import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wallpaper/Models/photo_model.dart';

class FetchApi

{
  static List<PhotoModel> images=[];
  static List<PhotoModel> searches=[];
  static Future<List<PhotoModel>> getWallpaper() async{
     await http.get(Uri.parse("https://api.pexels.com/v1/curated?page=4&per_page=80"),headers: {"Authorization":"Skwi3zFJxMCwfIM9HC46Yu68KML8A8wtUWpdu8rWVd9TpU7z4fTRPt53"}).then((value){
       Map<String,dynamic> jsonData=jsonDecode(value.body);
       List data=jsonData["photos"];
       data.forEach((element){
         images.add(PhotoModel.getImages(element));
       });
     });
     return images;
     
  }
   static Future <List<PhotoModel>> searchWallpaper(String search)async
  {
    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=${search}&page=1&per_page=80"),headers: {"Authorization":"Skwi3zFJxMCwfIM9HC46Yu68KML8A8wtUWpdu8rWVd9TpU7z4fTRPt53"}).then((value){
      Map<String,dynamic> jsonData=jsonDecode(value.body);
      List data=jsonData["photos"];
      searches.clear();
      data.forEach((element){
        searches.add(PhotoModel.getImages(element));
      });
    });
    return searches;
  }

}