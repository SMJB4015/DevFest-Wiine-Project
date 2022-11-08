
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wiine/blocs/map/map_bloc.dart';
import 'package:wiine/blocs/map/map_events.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/services.dart';
import 'package:wiine/blocs/map/map_states.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:wiine/constantes.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'screens/home.dart';
import '../constantes.dart';

Future<void> _showSearchDialog(context) async {
  var p = await PlacesAutocomplete.show(
      context: context,
      apiKey: GoogleK,
      mode: Mode.overlay,
      language: "us",
      region: "us",
      offset: 0,
      hint: "Type here...",
      radius: 1000,
      types: [],
      strictbounds: false,
      components: [Component(Component.country, "us")]);
  _getLocationFromPlaceId(p!.placeId!);
}

Future<void> _getLocationFromPlaceId(String placeId) async {
  GoogleMapsPlaces _places = GoogleMapsPlaces(
    apiKey: GoogleK,
    apiHeaders: await GoogleApiHeaders().getHeaders(),
  );

  PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);

  _animateCamera(LatLng(detail.result.geometry!.location.lat,
      detail.result.geometry!.location.lng));
}
Future<void> _animateCamera(LatLng _location) async {
  Completer<GoogleMapController> cntrl=Completer() ;
  final GoogleMapController controller = await cntrl.future;
  CameraPosition _cameraPosition = CameraPosition(
    target: _location,
    zoom: 13.00,
  );
  print(
      "animating camera to (lat: ${_location.latitude}, long: ${_location.longitude}");
  controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
}
void AddMArker(context){
  showBarModalBottomSheet(context: context, builder:(context)=>
      Container(height: 600,
        child:Padding(padding: EdgeInsets.all(8.0),
            child:Column(children: <Widget>[
              Row(children: [
                Text('data'),
                IconButton(onPressed: (){Navigator.of(context).pop() ;}, icon: Icon(Icons.arrow_back))
              ],
              )
            ],
            )
        ) ,
      ) ) ;
}
double convert(double e){
  var x=e.toString();
  var d= x.substring(0,8) ;
  var g=double.parse(d);
  return g;
}
getplacename() async {
  var res= await http.post(Uri.parse('http://api.positionstack.com/v1/reverse?access_key=70a8255ea7af923d8dd0ab883416b37a&query=40.7638435,-73.9729691'),
      headers: {},
      body: {});
  final data= json.decode(res.body);
  if(data['token']!=''){
    return data;

  }else{
    return data['detail'];
  }


}
Set<Marker> defM(List<Markker> mks){
      Set<Marker> Mkks={} ;
      Marker mk ;
      for (var i in mks){
        Mkks.add(i.mk) ;
      }
      return Mkks ;

}
void info(Markker mk) {
  String ch='' ;
  for(var i in mk.produits){
    ch=ch+i.name+' , ';
  }
  Marker mq = Marker(markerId: mk.mk.markerId,position: mk.mk.position,infoWindow: InfoWindow(title: ch)) ;
  mk.mk=mq;
}


