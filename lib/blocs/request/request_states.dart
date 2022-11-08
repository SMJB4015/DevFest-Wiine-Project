import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/models/request.dart';

class ReqStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class InitRStat extends ReqStates {}

class RequestsInitState extends ReqStates{
 List<Request> requests;
  RequestsInitState({required this.requests}) ;
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];

}