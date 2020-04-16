import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

Global globalFromJson(String str) => Global.fromJson(jsonDecode(str));

class Global {
  int updated;
  int cases;
  int todayCases;
  int deaths;
  int recovered;
  int active;
  int critical;
  int casesPerOneMillion;
  int deathsPerOneMillion;
  int tests;
  int testsPerOneMillion;
  int affectedCountries;

  Global();

  factory Global.fromJson(Map<String, dynamic> json) => Global();
}


