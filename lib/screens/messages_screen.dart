import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiine/blocs/message/message_bloc.dart';
import 'package:wiine/blocs/message/message_states.dart';
import 'package:wiine/constantes.dart';
import 'package:wiine/models/user.dart';

import '../blocs/message/message_events.dart';

class MeSS extends StatefulWidget{
  @override
  State<MeSS> createState() => SMeSS() ;

}

class SMeSS extends State<MeSS> {
  late MessageBloc BlocM;

  @override
  void initState() {
    BlocM = BlocProvider.of<MessageBloc>(context);
    BlocM.add(StartMEvent());

  }
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.green[300],
    minimumSize: Size(20, 80),
    padding: EdgeInsets.all(5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc,MessageStates>(builder: (context, state) {
      if (state is MainState) {
        return Scaffold(bottomNavigationBar: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 3, blurRadius: 10),
          ],
        ),
          child: ClipRRect(borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_basket), label: 'Requests'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.email), label: 'Messages'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]
              ,onTap: (index){
              if(index==0){        Navigator.pop(context);}
            },
              backgroundColor: Colors.green,
              fixedColor: Colors.lightGreenAccent,
              selectedFontSize: 15,
              unselectedFontSize: 10,
              unselectedItemColor: Colors.white,
              currentIndex: 1,
            ),
          ),
        ),
            backgroundColor: Colors.green,body:  Column(

                children:<Widget>[SizedBox(height: 250,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Messenger',style: TextStyle(color: Colors.white,fontSize: 30),),
                  ],
                ),),Expanded(child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft:Radius.circular(25) )),
                  child: ListView.builder(itemCount: state.users.length,scrollDirection: Axis.vertical ,physics: BouncingScrollPhysics(),itemBuilder: (context,index){

                    return Container(
                        height: 120,
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                          BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    state.users[index],
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Contact",
                                    style: const TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold),
                                  ),SizedBox(height:30,width: 80,child: ElevatedButton(onPressed: (){
                                    BlocM.add(SelectedUserEvent(reciver: state.users[index]));
                                    }, style: raisedButtonStyle,child: Text("Send")))
                                ],
                              ),
                              Icon(Icons.person)
                            ],
                          ),
                        ));
                    ;}
                  ),
                )
                )
                ]

            ));
      }else if(state is SelectedUserState){
        Future<List<Message>> att()async{
          var pref= await SharedPreferences.getInstance();
          var email=pref.getString('email') ;
          late User u ;
          Uri url= Uri.parse('${uurl}User/FindByEmail/${state.rec}');
          Uri url2= Uri.parse('${uurl}User/FindByEmail/${email}');

          var res= await http.get(url, headers: {});
          var res2= await http.get(url2, headers: {});

          final data= json.decode(res.body);
          final data2= json.decode(res.body);

          u=User.fromJson(data);
          var u2=User.fromJson(data2);

          List<Message>m1=[] ;
          List<Message>m2=[] ;
          for(var i in u.messages){
            if(i.senderEmail==state.rec){
              m1.add(i);
            }
          }
          for(var i in u2.messages){
            if(i.senderEmail==email){
              m2.add(i);
            }
          }
          for(var i in m1){
            m2.add(i) ;
          }
          return m2 ;

        }
        List<Message>m1=[] ;
        List<Message>m2=[] ;
        for(var i in state.sender.messages){
          if(i.senderEmail==state.rec){
            m1.add(i);
          }
        }
        for(var i in state.rec.messages){
          if(i.senderEmail==state.sender.email){
            m2.add(i);
          }
        }
        for(var i in m1){
          m2.add(i) ;
        }

        return Scaffold(bottomNavigationBar: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 3, blurRadius: 10),
          ],
        ),
          child: ClipRRect(borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_basket), label: 'Requests'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.email), label: 'Messages'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]
              ,onTap: (index){
              if(index==0){        Navigator.pop(context);}
            },
              backgroundColor: Colors.green,
              fixedColor: Colors.lightGreenAccent,
              selectedFontSize: 15,
              unselectedFontSize: 10,
              unselectedItemColor: Colors.white,
              currentIndex: 1,
            ),
          ),
        ),
            backgroundColor: Colors.green,body:  Column(

                children:<Widget>[SizedBox(height: 250,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Users',style: TextStyle(color: Colors.white,fontSize: 30),),
                  ],
                ),),Expanded(child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft:Radius.circular(25) )),
                  child: ListView.builder(itemCount: m2.length,scrollDirection: Axis.vertical ,physics: BouncingScrollPhysics(),itemBuilder: (context,index){
                    return Container(
                        height: 120,
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                          BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    m2[index].senderEmail,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    m2[index].messageText,
                                    style: const TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold),
                                  ),SizedBox(height:30,width: 80,child: ElevatedButton(onPressed: (){
                                  }, style: raisedButtonStyle,child: Text("Send")))
                                ],
                              ),
                              Icon(Icons.person)
                            ],
                          ),
                        ));
                    ;}
                  ),
                )
                )
                ]

            ));
      }
      else
        return Text('data');
    });
  }
}

