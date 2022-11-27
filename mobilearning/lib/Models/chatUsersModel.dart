// ignore_for_file: file_names

class ChatUsers {
  String name;
  String imageURL;
  DateTime createTime;
  DateTime lastLogin;
  String  status;
  int userUid;
  ChatUsers(
      {required this.name,
      required this.imageURL,
      required this.createTime,
      required this.userUid,
      required this.lastLogin,
      required this.status

      
      });

  static ChatUsers fromJson(Map<String, dynamic> json) {
    return ChatUsers(
        name: json['name'],
        imageURL: json['imageURL'],
        createTime: json['createTime'].toDate(),
        userUid: json['userUid'],
        lastLogin: json['lastLogin'].toDate(),
        status: json['status']
        );
  }

   Map<String, dynamic> toJson() => {
    "name": this.name,
    "imageURL": this.imageURL,
    "createTime": this.createTime,
    "userUid": this.userUid,
    "lastLogin":this.lastLogin,
    "status":this.status
 };

}
