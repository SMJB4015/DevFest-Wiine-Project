import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:wiine/models/user.dart';

class MessageEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class StartMEvent extends MessageEvents{}
class MessageButtonPressed extends MessageEvents{
  List<User> users ;
  List<Message> recivedMessages ;
  List<Message> envoiMessages ;

  MessageButtonPressed({required this.users, required this.recivedMessages,required this.envoiMessages});
}
class AddMEvent extends MessageEvents{
  final String? sender ;
  final String? message ;
  final String? reciver ;
  final String date ;

  AddMEvent({required this.sender, required this.message,required this.date,required this.reciver});
}
class SelectedUserEvent extends MessageEvents{
  final String? reciver ;

  SelectedUserEvent({required this.reciver});
}


