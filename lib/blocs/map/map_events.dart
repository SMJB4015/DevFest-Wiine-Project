import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/models/request.dart';
class MapEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class StartEvent extends MapEvents{}

class AddMEvent extends MapEvents{
  LatLng xy ;
  List<Markker> Markers ;
  List<bool?> values ;
  List<Produit> produits ;
  List<Request> Reqs ;
  AddMEvent({required this.xy,required this.Markers,required this.values,required this.produits,required this.Reqs});
}

class UpdtEvent extends MapEvents{
  LatLng xy ;
  Set<Marker> Markers ;
  List<bool?> values ;
  List<String> produits ;
  UpdtEvent({required this.xy,required this.Markers,required this.values,required this.produits});
}
class AddReqevent extends MapEvents {
  Markker x;

  String user;
  List<Request> reqs;

  List<Markker> Markers ;
  List<bool?> values;

  List<Produit> produits;

  AddReqevent({required this.x, required this.user, required this.produits, required this.values, required this.reqs,required this.Markers});
}
