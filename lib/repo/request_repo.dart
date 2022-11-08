import 'dart:convert';

import 'package:http/http.dart' as http;
class ReqRepo {
  register() async {
    var res= await http.post(Uri.parse('http://api.positionstack.com/v1/reverse?access_key=70a8255ea7af923d8dd0ab883416b37a&query=40.7638435,-73.9729691'),
        headers: {},
        body: {});
    final data= json.decode(res.body);
    if(data['token']!=''){
      return data;

    }else{
      return data['detail'];
    }


  }
}