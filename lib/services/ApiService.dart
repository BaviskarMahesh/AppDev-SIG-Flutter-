import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService{
  Future<List<dynamic>> getMedicine() async{
    final uri=Uri.https(
      'api.fda.gov',
      '/drug/label.json',
      {
        'search':'openfda.generic_name:*',
        'limit':'100',
      }
    );

    final response =await http.get(uri);
    if(response.statusCode==200){
      final data=json.decode(response.body);
      return data['results'];
    }else{
      throw Exception("Failed to load medicines");
    }
  }
}