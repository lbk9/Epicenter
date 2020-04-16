import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:covidtracker/models/global.dart';
import 'dart:async';

class CovidApiService {
  Future<Global> getGlobalStats() async {
    Map global;
    try{
      Response response = await get('https://corona.lmao.ninja/v2/all');
      return global = json.decode(response.body);
    } catch (e){
      print(e);
    }
  }
}