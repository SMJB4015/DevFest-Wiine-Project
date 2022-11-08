
import 'package:wiine/blocs/message/message_events.dart';
import 'package:wiine/blocs/message/message_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repo/message_repo.dart';

class MessageBloc extends Bloc<MessageEvents,MessageStates>{
  MesRepo repo;
  MessageBloc(MessageStates InitState,this.repo) : super(InitState){
    on<StartMEvent>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      var email=pref.getString('email') ;
      List<String> userR=[];
      var users = await repo.getAllE(email!) ;
      var usr = await repo.getAllR(email);
      userR.add(usr.messages.first.senderEmail);
      for(var i in usr.messages){
        if(userR.contains(i.senderEmail)==false){
          userR.add(i.senderEmail) ;
        }
      }for(var i in users){
        if(userR.contains(i.email)==false){
          userR.add(i.email) ;
        }
      }


        emit(MainState(users: userR));

    });
    on<SelectedUserEvent>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      var email=pref.getString('email') ;
     var UserE=repo.getAllR(email!) ;
     var UserR=repo.getAllR(event.reciver!) ;
      emit(SelectedUserState(rec: UserR,sender: UserE));
    });
}}


