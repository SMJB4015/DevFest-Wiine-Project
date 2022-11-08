import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/models/request.dart';
class ReqEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class StartREvent extends ReqEvents{}

class AddReqeevent extends ReqEvents{
  Markker x ;
  String user;
  List<Request> reqs;
  //Set<Marker> Markers ;
  List<bool?> values ;
  List<Produit> produits ;
  AddReqeevent({required this.x,required this.user,required this.produits,required this.values,required this.reqs});
}
