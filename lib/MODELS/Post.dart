// ignore_for_file: file_names

class Post {
  
  final String userName;

  final bool isCreate;
  final String hour;
  final String imgPath;
  final String postImage;

  Post({required this.userName, required this.hour, required this.imgPath, required this.isCreate, required this.postImage});

  factory Post.fromJson(Map<String,dynamic> json) { 
    return Post(
      userName: json['username'],
      isCreate: json['isCreate'],
      hour: json['hour'],
      imgPath: json['imgPath'],
      postImage: json['postImage']
      );
  }
}

class NetworkURL{
  static var URL= "http://10.194.109.26:8000";
 
}