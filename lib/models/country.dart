import 'dart:io';
import 'dart:convert';
import 'package:covidtracker/models/countryinfo.dart';

class Country{
  String country;
  CountryInfo countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  int casesPerOneMillion;
  int deathsPerOneMillion;
  int updated;
}

