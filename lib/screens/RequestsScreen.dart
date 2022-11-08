import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiine/blocs/map/map_bloc.dart';
import 'package:wiine/blocs/map/map_states.dart';
import 'package:wiine/blocs/request/request_bloc.dart';
import 'package:wiine/blocs/request/request_states.dart';
import 'package:wiine/screens/ReqDetails.dart';
import 'package:wiine/screens/home.dart';

class RequestS extends StatefulWidget{
  @override
  State<RequestS> createState() => SRequets() ;

}

class SRequets extends State<RequestS> {
  late MapBloc Map;

  @override
  void initState() {
    Map = BlocProvider.of<MapBloc>(context);
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
    return BlocBuilder<MapBloc,MapStates>(builder: (context, state) {
      if (state is MapInitState) {
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
            Text('Requests',style: TextStyle(color: Colors.white,fontSize: 30),),
          ],
        ),),Expanded(child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft:Radius.circular(25) )),
          child: ListView.builder(itemCount: state.Requests.length,scrollDirection: Axis.vertical ,physics: BouncingScrollPhysics(),itemBuilder: (context,index){

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
                            state.Requests[index].user,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Place to find",
                            style: const TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold),
                          ),SizedBox(height:30,width: 80,child: ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute<ReqDetails>(builder: (_)=>
                                MultiBlocProvider(providers: [BlocProvider.value(value: BlocProvider.of<MapBloc>(context))],
                                    child:ReqDetails(re: state.Requests[index] )))
                            );
                          }, style: raisedButtonStyle,child: Text(" Details")))
                        ],
                      ),
                      Image.asset(
                        'assets/box.png',
                        height: double.infinity,
                      )
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

