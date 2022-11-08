import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/blocs/map/map_bloc.dart';
import 'package:wiine/blocs/map/map_states.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/repo/map_repo.dart';
import 'package:wiine/screens/Home.dart';

import '../blocs/map/map_events.dart';



class Mark extends StatefulWidget{
  final List<Produit> produits;
  final LatLng lng ;
  Mark({required this.produits,required this.lng});
  @override
  State<Mark> createState() => _Mark() ;
}

class _Mark extends State<Mark>{
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.all(12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
  List<CheckboxListTile> cc=[];
  late MapBloc blocMap ;
  @override
  void initState() {
      blocMap=BlocProvider.of<MapBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    List<bool?> values=List.generate(widget.produits.length, (index) => false) ;
    return  BlocBuilder<MapBloc,MapStates>(builder: (context, state){
      if (state is MapInitState){
        return StatefulBuilder(
            builder: (context,StateSetter st) {
              List<CheckboxListTile> cc =List.generate(values.length, (index) =>
                  CheckboxListTile(
                      tileColor: Colors.black45,value: values[index],title: Text(widget.produits[index].name,style: TextStyle(fontSize: 20,color: Colors.white),), onChanged: (val){ st(() { values[index]=val;});}
                  ));
              return Scaffold(
                body: SafeArea(
                  child: Container(color: Colors.indigo,
                    child:Padding(padding: EdgeInsets.all(8.0),
                        child:Column(children: <Widget>[
                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Text('Add Marker',style: TextStyle(fontSize: 30,color: Colors.white),)
                          ],),
                          Expanded(
                            child: ListView.builder(
                              itemCount: cc.length,
                              itemBuilder: (context, index) {
                                return cc[index];
                              },
                            ),
                          ),ElevatedButton(style: raisedButtonStyle,child: Text('Add',style: TextStyle(color: Colors.indigo),),onPressed: (){
                            blocMap.add(AddMEvent(xy: widget.lng, Markers: state.Markers,values: values,produits: widget.produits,Reqs: state.Requests));
                            Future.delayed(Duration.zero, (){Navigator.push(context, MaterialPageRoute<Home>(builder: (_)=>
                                MultiBlocProvider(
                                    providers: [
                                      BlocProvider(create: (context) => MapBloc(InitStat(), MapRepo())),
                                    ],child: Home())
                            ));} );
                          })
                        ]

                        )
                    ) ,
                  ),
                ),
              );
            }
        );
      } else return Text('data') ;
    });

  }
}