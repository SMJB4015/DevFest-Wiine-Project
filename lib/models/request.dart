import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wiine/models/markker.dart';

class Request{
  String id ;
  String user ;
  String mk ;
  List<Produit> produits ;
  Request({required this.id,required this.user,required this.mk,required this.produits}) ;
  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json["id"],
    user: json["userId"],
    mk: json["markerId"],
    produits: List<Produit>.from(json["products"].map((x) => Produit.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": user,
    "markerId":mk,
    "valable_Products":List<dynamic>.from(produits.map((x) => x.toJson())),
  };
}