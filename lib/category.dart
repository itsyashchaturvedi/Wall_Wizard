import "package:flutter/material.dart";

class Category extends StatefulWidget {
  String catName;
  Category({super.key,required this.catName});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late String catImages;
  @override
  void initState() {
    super.initState();
    if(widget.catName=="Love"){
      catImages="https://images.pexels.com/photos/1767434/pexels-photo-1767434.jpeg?auto=compress&cs=tinysrgb&w=600";
    }
    else if(widget.catName=="Cars"){
      catImages="https://images.pexels.com/photos/164634/pexels-photo-164634.jpeg?auto=compress&cs=tinysrgb&w=600";
    }
    else if(widget.catName=="Street"){
      catImages="https://images.pexels.com/photos/814830/pexels-photo-814830.jpeg?auto=compress&cs=tinysrgb&w=600";
    }
    else if(widget.catName=="Pet"){
      catImages='https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=600';
    }
    else if(widget.catName=="Flowers"){
      catImages='https://images.pexels.com/photos/68507/spring-flowers-flowers-collage-floral-68507.jpeg?auto=compress&cs=tinysrgb&w=600';
    }
    else if(widget.catName=="City"){
      catImages='https://images.pexels.com/photos/169647/pexels-photo-169647.jpeg?auto=compress&cs=tinysrgb&w=600';
    }
    else if(widget.catName=="Nature"){
      catImages='https://images.pexels.com/photos/147411/italy-mountains-dawn-daybreak-147411.jpeg?auto=compress&cs=tinysrgb&w=600';
    }
    else if(widget.catName=="Dark"){
      catImages='https://images.pexels.com/photos/1097456/pexels-photo-1097456.jpeg?auto=compress&cs=tinysrgb&w=600';
    }
    else if(widget.catName=="Bikes"){
      catImages="https://images.pexels.com/photos/1413412/pexels-photo-1413412.jpeg?auto=compress&cs=tinysrgb&w=600";
    }
  }
  @override
  Widget build(BuildContext context) {
    return
       Padding(
         padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
         child: SizedBox(
            width: 140,
            child: Stack(
            children:[
              Container(
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                 borderRadius: BorderRadius.circular(20),
                    child: Image.network(fit: BoxFit.fill,catImages,height: 115,),),
              ),
              Container(decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(20))),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child:Column(children: [
                  Expanded(child: SizedBox()),
                  Center(child: Text(widget.catName,style:const TextStyle(color: Colors.white,fontSize: 21),))
                ],),),

            ]
                ),
          ),
       );


  }
}
