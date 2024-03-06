import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/cat_model.dart';

class CatsProvider extends ChangeNotifier{
  var Loading = true;
  var cats = <Cat_Model>[];
  var serchedpets = <Cat_Model>[];
  var error = '';
  String searchedText ='';
  Future<void> getCatsData() async{
    try {
      var url = 'https://6592aba1bb129707198fed35.mockapi.io/api/cats';
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final List json = jsonDecode(response.body);
        cats = json.map((e)=> Cat_Model.fromJson(e)).toList();
        Loading = false;
        updateData();
        notifyListeners();
      }else{
        error = '${response.statusCode} : ${response.reasonPhrase}';
        log(error);
      }
    } catch (e) {
      error = e.toString();
      log(error);
    }
    
  }
   updateData() async{
    serchedpets.clear();
    if(searchedText.isEmpty){
      serchedpets.addAll(cats);
    }else{
      serchedpets.addAll(cats.where((element) => element.name!.toLowerCase().startsWith(searchedText)).toList());
    }
    notifyListeners();
  }

  SearchData(String username) async{
    searchedText = username;
    updateData();
  }
}