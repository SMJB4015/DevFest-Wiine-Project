import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wiine/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiine/models/user.dart';
class MesRepo {
  getAllR(String email) async {
    late User u ;
    Uri url= Uri.parse(uurl+'User/FindByEmail/'+email);

    var res= await http.get(url,
        headers: {});
    final data= json.decode(res.body);

    if(data['email']!=''){
      return   u=User.fromJson(data);

    }else{
      return data['error'];
    }


  }
  getAllE(String email) async {
    List<User> users=[] ;
    List<User> users2=[] ;
    Uri url= Uri.parse(uurl+'User/findUsersMessages/'+email);

    var res= await http.get(url,
        headers: {});
    final data= json.decode(res.body);
    data.map((user) => users.add(User.fromJson(user))).toList();
    users2.add(users.first) ;
    for (var i in users){
      if(users2.contains(i)==false){
        users2.add(i) ;
      }
    }
    return users2;
  }
  EnvoiM(String senderEmail,String RecEmail,String messageText,String date) async {
    var pref= await SharedPreferences.getInstance();
    Uri url= Uri.parse(uurl+'User/addMessage/'+senderEmail+'/'+RecEmail);
    var res= await http.post(url,
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({"messageText":senderEmail,"date":date}));
    final data= json.decode(res.body);
    if(data['email']!=''){
      return data;

    }else{
      return data['error'];
    }


  }

}