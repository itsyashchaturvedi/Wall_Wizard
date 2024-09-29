import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';



class FullScreen extends StatefulWidget {

  final String imgUrl;
  const FullScreen({super.key,required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  String? progressto;
  Future <void> downloadImage(String url) async{
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Downloading")));
    var file=await FileDownloader.downloadFile(url: url,
     name: 'Wall_Wizard',
     notificationType: NotificationType.all,
     onDownloadCompleted: (path){
      setState(() {
        progressto=path;
      });
     }
   );
    print(progressto);
   if(file==null)
     {
       return;
     }
   else
     {
       ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Downloaded Successfully"),));
     }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.network(widget.imgUrl,fit: BoxFit.fill,height: MediaQuery.of(context).size.height,),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                height: 120,
                  child: IconButton(onPressed: (){Navigator.of(context).pop();}, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,))),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                      onPressed: (){
                        downloadImage(widget.imgUrl);
                      },
                      child: const Text("Download",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),
                    ),
                    const SizedBox(height: 45,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
