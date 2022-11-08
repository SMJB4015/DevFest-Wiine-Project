import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/models/markker.dart';
import 'package:wiine/models/request.dart';
import 'package:wiine/repo/request_repo.dart';
import 'request_events.dart';
import 'request_states.dart';
import 'package:wiine/repo/map_repo.dart';


class ReqBloc extends Bloc<ReqEvents,ReqStates>{
  ReqRepo repo ;
  ReqBloc(ReqStates InitStat,this.repo ) : super(InitStat) {
    on<StartREvent>((event, emit) async {
      List<Request> reqs=[] ;
      emit(RequestsInitState(requests: reqs));

    }) ;
    on<AddReqeevent>((event, emit) {
     Markker mk = event.x;
     List<Produit> produitRq=[];
     for(var i=0 ;i<event.produits.length;i++){
       if(event.values[i] == true){
         produitRq.add(event.produits[i]) ;
       }
     }
     List<Request> rqs=event.reqs;
      Request req = Request(id:'0',user: event.user, mk: mk.id, produits: produitRq);
      rqs.add(req) ;
      emit(RequestsInitState(requests: rqs));

    });
  }}