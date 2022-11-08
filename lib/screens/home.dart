import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiine/blocs/map/map_bloc.dart';
import 'package:wiine/blocs/map/map_events.dart';
import 'package:wiine/blocs/message/message_bloc.dart';
import 'package:wiine/blocs/message/message_states.dart';
import 'package:wiine/blocs/request/request_bloc.dart';
import 'package:wiine/blocs/request/request_events.dart';
import 'package:wiine/blocs/request/request_states.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/repo/message_repo.dart';
import 'package:wiine/repo/request_repo.dart';
import 'package:wiine/screens/MarkDetails.dart';
import 'package:wiine/screens/MarkerAdd.dart';
import 'package:wiine/screens/RequestsScreen.dart';
import 'package:wiine/screens/messages_screen.dart';
import 'package:wiine/services.dart';
import 'package:wiine/blocs/map/map_states.dart';
import 'package:wiine/repo/request_repo.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:wiine/constantes.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../blocs/auth/auth_events.dart';
import '../constantes.dart';



class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _Home() ;
}

class _Home extends State<Home> {
  late MapBloc blocMap ;
  Completer<GoogleMapController> cntrl=Completer() ;
  LatLng current =LatLng(0,0);
  List<CheckboxListTile> ls =[];

  @override
  void initState() {
    blocMap=BlocProvider.of<MapBloc>(context);
    blocMap.add(StartEvent());
    super.initState();
  }
  @override
  void dispose() {
    blocMap.close();
    super.dispose();
  }
  Widget build(BuildContext context) {
        return Scaffold(
            bottomNavigationBar: Container(decoration: BoxDecoration(
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
                      if(index==1){ Navigator.push(context, MaterialPageRoute<RequestS>(builder: (_)=>
                          MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<MapBloc>(context))],
                              child:RequestS()))
                      );}
                      if(index==2){ Navigator.push(context, MaterialPageRoute<MeSS>(builder: (_)=>
                          MultiBlocProvider(
                              providers: [
                                BlocProvider(create: (context) => MessageBloc(InitState(), MesRepo())),
                              ],child: MeSS())

                      ));}
                },
                    backgroundColor: Colors.green,
                    fixedColor: Colors.lightGreenAccent,
                    selectedFontSize: 15,
                    unselectedFontSize: 10,
                    unselectedItemColor: Colors.white
                ),
              ),
            ),
            appBar: AppBar(
                centerTitle: false,
                title: Text('Wiine', style: TextStyle(color: Colors.black45),),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
                backgroundColor: Colors.white,
                actions: <Widget>[IconButton(
                  padding: EdgeInsets.only(right: 20),
                  onPressed: () {
                    //_showSearchDialog();
                  },
                  icon: Icon(Icons.search),
                  color: Colors.green,)
                ]
            ),
            body: BlocBuilder<MapBloc,MapStates>(builder: (context, state)
                {
                 if(state is MapInitState){
                   for(var i in state.Markers){
                     acti(i) ;
                   }
                             return Stack(children: [
                                  GoogleMap(
                                    initialCameraPosition: state.initialPos,
                                  onMapCreated: ((controller) => cntrl.complete(controller)),
                                  onCameraMove: (e)=> current=e.target,
                                  markers: defM(state.Markers)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 350,bottom: 100,right: 5),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FloatingActionButton(onPressed: (){
                                       // blocMap.add(AddMEvent(xy: current, Markers: state.Markers));
                                        //BottomPage AddMarkeur
                                        //   return Mark(lis: state.test) ;

                                        Navigator.push(context, MaterialPageRoute<Mark>(builder: (_)=>
                                            MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<MapBloc>(context))], child:Mark(produits: state.produits,lng: current,))));


                                        },
                                        child: Icon(Icons.add),backgroundColor: Colors.green,),
                                      FloatingActionButton(onPressed: ()async{
                                        final GoogleMapController controler= await cntrl.future ;
                                         controler.animateCamera(CameraUpdate.newCameraPosition(state.initialPos));
                                      },child: Icon(Icons.gps_fixed),backgroundColor: Colors.green,),
                                    ],),
                                  )
                                  ]
                                  );
                                  }
                            else if (state is InitStat){
                                return Scaffold(backgroundColor: Colors.white,body: Center(child: CircularProgressIndicator(color: Colors.indigo)));
                                }
                        else return Text('e') ;
            })
        );

    }



  void acti(Markker mkk) {
    Marker mq = Marker(markerId: mkk.mk.markerId,position: mkk.mk.position,infoWindow: mkk.mk.infoWindow,onTap: (){
      Navigator.push(context, MaterialPageRoute<Mark>(builder: (_)=>
          MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<MapBloc>(context))],
              child:Markdetails(Mk: mkk)))
      );
    }) ;
    mkk.mk=mq;
  }

  }
