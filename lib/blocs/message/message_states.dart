import 'package:equatable/equatable.dart';
import 'package:wiine/blocs/map/map_states.dart';
import 'package:wiine/models/user.dart';

class MessageStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class InitState extends MessageStates{
}
class MainState extends MessageStates{
  List<String> users ;
MainState({required this.users}) ;

}

class MessageLoadingState extends MessageStates{}
class SelectedUserState extends MessageStates{
  final User sender ;
  final User rec ;

  SelectedUserState({required this.sender,required this.rec});
}
class AddMesState extends MessageStates{
  final String? sender ;
  final String? message ;
  final String? reciver ;
  final String date ;

  AddMesState({required this.sender, required this.message,required this.date,required this.reciver});
}


