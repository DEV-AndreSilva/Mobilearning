// ignore_for_file: file_names

class ChatMessage{
  String messageId;
  String messageContent;
  String idUserWritter;
  DateTime dateSent;

  ChatMessage(
    {
      required this.messageId,
      required this.messageContent,
      required this.dateSent,
     required this.idUserWritter}
  );
 Map<String, dynamic> toJson() => {
    "messageId": this.messageId,
    "messageContent":this.messageContent,
    "idUserWritter": this.idUserWritter,
    "dateSent": this.dateSent
 };

 static ChatMessage fromJson(Map<String,dynamic> json)
 {
  return ChatMessage(
    messageId: json['messageId'], 
    messageContent: json['messageContent'],
    idUserWritter: json['idUserWritter'],
    dateSent:  json['dateSent'].toDate()
    );
 }
}