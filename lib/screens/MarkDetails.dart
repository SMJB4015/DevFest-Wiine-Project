import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/blocs/map/map_bloc.dart';
import 'package:wiine/blocs/map/map_states.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/screens/RequestsScreen.dart';
import 'package:wiine/blocs/map/map_events.dart';





class Markdetails extends StatefulWidget{
  final Markker Mk ;
  Markdetails({required this.Mk});
  @override
  State<Markdetails> createState() => _MarkD() ;
}

class _MarkD extends State<Markdetails>{
  List<CheckboxListTile> cc=[];
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.all(12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
  late MapBloc blocMap ;
  @override
  void initState() {
    blocMap=BlocProvider.of<MapBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    List<bool?> values=List.generate(widget.Mk.produits.length, (index) => true) ;
    return  BlocBuilder<MapBloc,MapStates>(builder: (context, state ){
      if (state is MapInitState){
        return StatefulBuilder(
            builder: (context,StateSetter st) {
              List<CheckboxListTile> cc =List.generate(values.length, (index) =>
                  CheckboxListTile(
                      tileColor: Colors.black45,value: values[index],title: Text(widget.Mk.produits[index].name,style: TextStyle(fontSize: 20,color: Colors.indigo),), onChanged: (val){ st(() { values[index]=val;});}
                  ));
              return Scaffold(
                body: SafeArea(
                  child: Container(color: Colors.indigo,
                    child:Padding(padding: EdgeInsets.all(8.0),
                        child:Column(children: <Widget>[
                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            Text('Marker',style: TextStyle(fontSize: 30,color: Colors.white),)
                          ],),
                          Expanded(
                            child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
                              child: ListView.builder(
                                itemCount: cc.length,
                                itemBuilder: (context, index) {
                                  return cc[index];
                                },
                              ),
                            ),
                          ),ElevatedButton(style: raisedButtonStyle,child: Text('Add Request ',style: TextStyle(color: Colors.indigo),),onPressed: (){
                           blocMap.add(AddReqevent(x: widget.Mk, user:'Saif', produits: widget.Mk.produits, values: values, reqs: state.Requests,Markers: state.Markers));
                            Navigator.pop(context);
                          }),

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