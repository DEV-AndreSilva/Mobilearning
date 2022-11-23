// ignore_for_file: file_names

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  DateTime time;
  int userUid;
  ChatUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time,
      required this.userUid});

  static ChatUsers fromJson(Map<String, dynamic> json) {
    return ChatUsers(
        name: json['name'],
        messageText: json['messageText'],
        imageURL: json['imageURL'],
        time: json['time'].toDate(),
        userUid: json['userUid']);
  }
}
