import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/blocs/map/map_bloc.dart';
import 'package:wiine/blocs/map/map_states.dart';
import 'package:wiine/blocs/request/request_bloc.dart';
import 'package:wiine/blocs/request/request_states.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/models/request.dart';
import 'package:wiine/screens/home.dart';

class ReqDetails extends StatefulWidget{
 final Request re ;
 ReqDetails({required this.re}) ;

  @override
  State<ReqDetails> createState() => SRequets() ;

}

class SRequets extends State<ReqDetails> {
  late MapBloc Map;
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.green[300],
    minimumSize: Size(20, 80),
    padding: EdgeInsets.all(5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
  @override
  void initState() {
    Map = BlocProvider.of<MapBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc,MapStates>(builder: (context, state) {
      if (state is MapInitState) {
        late Markker mk ;
        for (var i in state.Markers){
          if(widget.re.mk ==i.id ){
            mk=i ;
          }
        }
        String ch='' ;
        for(var j in widget.re.produits){
          ch=ch+j.name+' | ' ;
        }
        Set<Marker>mks={};
        mks.add(mk.mk) ;
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
            backgroundColor: Colors.green,body:  SafeArea(
              child: Column(

                  children:<Widget>[SizedBox(height: 250,child: GoogleMap(initialCameraPosition: CameraPosition(target: mk.mk.position,zoom: 7),markers: mks,)),
                    Expanded(child:
                    Column(children: [
                      Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text('Details',style: TextStyle(color: Colors.green,fontSize: 40),),
                        ],),
                    ),SizedBox(width: 20,height: 20,),
                      Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text('Place :',style: TextStyle(color: Colors.blueGrey,fontSize: 25),),SizedBox(width: 100,height: 20,),
                              Text('exemple',style: TextStyle(color: Colors.green,fontSize: 20),),],),
                            Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text('Owner :',style: TextStyle(color: Colors.blueGrey,fontSize: 25),),SizedBox(width: 100,height: 20,),
                              Text(widget.re.user,style: TextStyle(color: Colors.green,fontSize: 20),),],),
                            Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text('Products :',style: TextStyle(color: Colors.blueGrey,fontSize: 25),),SizedBox(width: 100,height: 20,),
                              ],),SingleChildScrollView(child: Text(ch,style: TextStyle(color: Colors.green,fontSize: 20),),)
                          ],
                        ),
                      ),SizedBox(width: 20,height: 20,),SizedBox(height:50,width: 200,child: ElevatedButton(onPressed: (){
                       // Navigator.push(context, MaterialPageRoute<ReqDetails>(builder: (_)=>
                         //   MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<MapBloc>(context))],
                           //     child:ReqDetails(re: state.Requests[index] )))
                        //);
                      }, style: raisedButtonStyle,child: Text(" Envoyer Message")))
                    ],)
                  )
                  ]

              ),
            ));
      }
      else
        return Text('data');
    });
  }
}

