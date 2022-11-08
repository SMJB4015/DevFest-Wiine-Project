import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/services.dart';

class Markker{
  String id;
  String place;
  double lat;
  double lng;
  Marker mk ;
  List<Produit> produits;
  Markker({required this.id,required this.place,required this.mk,required this.lat,required this.lng,required this.produits});
  factory Markker.fromJson(Map<String, dynamic> json) => Markker(
    id: json["id"],
    place: json["placeN"],
    lat: json["lat"],
    lng: json["longeur"],
    mk: Marker(markerId: MarkerId(json['id']),position: LatLng(json["lat"],json["longeur"]),visible: true),
    produits: List<Produit>.from(json["valable_Products"].map((x) => Produit.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "placeN": place,
    "lat":lat,
    "longeur":lng,
    "valable_Products":List<dynamic>.from(produits.map((x) => x.toJson())),
  };
}
class Produit {
  Produit({
   required this.id,
    required this.name
  });

  String id;
  String name;

  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
    id: json["id"],
    name: json["name"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}