import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/models/request.dart';

class MapStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class InitStat extends MapStates {}

class MapInitState extends MapStates{
  List<Markker> Markers ;
  List<Request> Requests ;
  CameraPosition initialPos ;
  List<Produit> produits ;
  MapInitState({required this.initialPos,required this.Markers,required this.produits,required this.Requests}) ;
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];

}
class MapSecState extends MapStates{
  Set<Marker> Markers ;
  CameraPosition initialPos ;
  MapSecState({required this.initialPos,required this.Markers}) ;}