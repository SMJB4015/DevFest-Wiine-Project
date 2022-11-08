import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/models/markker.dart';

class User{
  String id ;
  String userName ;
  String email ;
  List<Message> messages ;
  User({required this.id,required this.userName,required this.email,required this.messages}) ;
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "email":email,
    "messages":List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}
class Message{
  String id ;
  String senderEmail ;
  String messageText ;
  String date ;
  Message({required this.id,required this.senderEmail,required this.messageText,required this.date}) ;
  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    senderEmail: json["senderEmail"],
    messageText: json["messageText"],
    date: json["messageText"],

  );

  Map<String, dynamic> toJson() => {
    "senderEmail": senderEmail,
    "messageText":messageText,
    "date":date,
  };
}
