import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/models/request.dart';
import 'package:wiine/services.dart';
import 'map_events.dart';
import 'map_states.dart';
import 'package:wiine/repo/map_repo.dart';


class MapBloc extends Bloc<MapEvents,MapStates>{
  MapRepo repo ;
  MapBloc(MapStates InitStat,this.repo ) : super(InitStat) {
    on<StartEvent>((event, emit) async {
      var loctionD = await repo.getLocation();
      LatLng pos = LatLng(loctionD.latitude!, loctionD.longitude!);
      CameraPosition cam = CameraPosition(target: pos, zoom: 7);
      final Marker mk=Marker(markerId: MarkerId('1'),icon: BitmapDescriptor.defaultMarkerWithHue(50),position: pos) ;
      var produits = await repo.getProducts();
      var markkers=await repo.getMarkers();
      var reqs= await repo.getReqs();
      for(var i in markkers){
        info(i) ;
      }
      emit(MapInitState(initialPos: cam, Markers: markkers,produits: produits,Requests: reqs));
    });
    on<AddMEvent>((event, emit) async {
      final id = event.xy.latitude.toString();
      List<Produit> produitss=[] ;
      String ch='' ;
      for(var i=0 ;i<event.produits.length;i++){
        if(event.values[i] == true){
          produitss.add(event.produits[i]) ;
         // ch=ch+produitss[i].name+' , ';
        }
      }
      final Marker mk=Marker(markerId: MarkerId(id),position: event.xy,infoWindow: InfoWindow(title: ch)) ;
      Markker mq= Markker(id: '0', place: 'sousse', mk: mk, lat: event.xy.latitude, lng: event.xy.longitude, produits: produitss) ;
      var data=await repo.AddMrk(mq);
      List<Markker> MArkerrs= event.Markers;
      List<Request> reqs=event.Reqs;
      //MArkerrs.add(mk);
      CameraPosition cam = CameraPosition(target: event.xy, zoom: 7);
      var produits = await repo.getProducts();
      emit(MapInitState(initialPos: cam, Markers: MArkerrs,produits: produits,Requests: reqs));




    });
    on<AddReqevent>((event, emit) async {
      Markker mk = event.x;
      CameraPosition cam = CameraPosition(target: event.x.mk.position, zoom: 7);
      List<Produit> produitRq=[];
      for(var i=0 ;i<event.produits.length;i++){
        if(event.values[i] == true){
          produitRq.add(event.x.produits[i]) ;
        }
      }
      List<Request> rqs=event.reqs;
      Request req = Request(id:'0',user: event.user, mk: mk.id, produits: produitRq);
      var data= await repo.AddReq(req);
      rqs.add(req) ;
      emit(MapInitState(initialPos: cam, Markers: event.Markers,produits:event.produits,Requests: rqs));

    });
  }
}