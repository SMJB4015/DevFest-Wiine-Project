import 'dart:convert';

import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiine/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:wiine/models/markker.dart';
import 'package:wiine/models/request.dart';

class MapRepo{
  Future<LocationData> getLocation() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
  throw Exception();
  }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
  throw Exception();
  }
  }

  _locationData = await location.getLocation();
  return _locationData;
  }
  Future<List<Produit>> getProducts()async{
    List<Produit> produits = [];
    Uri url= Uri.parse(uurl+'Product/FindAll');
    var res= await http.get(url,
        headers: {});
    final data= json.decode(res.body);
    data.map((produit) => produits.add(Produit.fromJson(produit))).toList();
    return produits;

  }
  Future<List<Markker>> getMarkers()async{
    List<Markker> markers = [];
    Uri url= Uri.parse(uurl+'Marker/FindAll');
    var res= await http.get(url,
        headers: {});
    final data= json.decode(res.body);
    data.map((marker) => markers.add(Markker.fromJson(marker))).toList();
    return markers;

  }
  Future<List<Request>> getReqs()async{
    List<Request> reqs = [];
    Uri url= Uri.parse(uurl+'Request/FindAll');
    var res= await http.get(url,
        headers: {});
    final data= json.decode(res.body);
    data.map((marker) => reqs.add(Request.fromJson(marker))).toList();
    return reqs;

  }
  AddMrk(Markker mk) async {
    Uri url= Uri.parse(uurl+'Marker/Add');
    var res= await http.post(url,
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({"placeN":mk.place,"longeur":mk.lng,"lat":mk.lat,"valable_Products":List<dynamic>.from(mk.produits.map((x) => x.toJson()))}));
    final data= json.decode(res.body);
    if(data['id']!=''){
      return data;

    }else{
      return data['error'];
    }


  }
  AddReq(Request mk) async {
    var pref= await SharedPreferences.getInstance();
    String? email=pref.getString('email');
    Uri url= Uri.parse(uurl+'Request/Add');
    var res= await http.post(url,
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({"userId":email,"markerId":mk.mk,"products":List<dynamic>.from(mk.produits.map((x) => x.toJson()))}));
    final data= json.decode(res.body);
    if(data['id']!=''){
      return data;

    }else{
      return data['error'];
    }


  }


}
