class PhotoModel{

  String imgSrc;
  String photgrapher;

  PhotoModel({required this.imgSrc,required this.photgrapher});

   static PhotoModel getImages(Map<String,dynamic> image){
    return PhotoModel(imgSrc: (image["src"])["portrait"], photgrapher: image["photographer"]);

   }

}

