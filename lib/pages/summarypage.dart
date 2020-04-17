import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  Map worldData;
  List countryList;

  String globalCases;
  String globalDeaths;
  String globalRecovered;

  fetchWorldWideData() async {
    Response response = await get('https://corona.lmao.ninja/v2/all');
    worldData = json.decode(response.body);
    setState(() {
      globalCases = '${worldData['cases']}';
      globalDeaths = '${worldData['deaths']}';
      globalRecovered = '${worldData['recovered']}';
    });
  }

  List affectedCountryData;
  String mostAffectedCountry;
  fetchMostAffected() async {
    Response response = await get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      affectedCountryData = json.decode(response.body);
      mostAffectedCountry = '${affectedCountryData[0]['country']}';
    });
  }

  List recoveredCountryData;
  String mostRecoveredCountry;
  fetchMostRecovered() async {
    Response response = await get('https://corona.lmao.ninja/v2/countries?sort=recovered');
    setState(() {
      recoveredCountryData = json.decode(response.body);
      mostRecoveredCountry = '${recoveredCountryData[0]['country']}';
    });
  }

    @override
    void initState() {
      fetchWorldWideData();
      fetchMostAffected();
      fetchMostRecovered();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(150, 70),
                    bottomLeft: Radius.elliptical(150, 70)),
                child: Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'Stay Home'
                        ),
                        Text(
                            'Save Lives'
                        )
                      ],
                    ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Common Symptoms',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    child: FlutterLogo(
                      size: 80,
                    ),
                  ),
                  Container(
                    color: Colors.orange,
                    child: FlutterLogo(
                      size: 80,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              child: Card(
                elevation: 15,
                color: Colors.grey[200],
                child: Container(
                  height: 250,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Total Cases',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 20
                              )),
                        ),
                      ),
                      Text(
                        globalCases,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.amber[800],
                              fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                                children: <Widget>[
                                  Text(
                                    'Total Deaths',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          fontSize: 20
                                        )
                                    ),
                                  ),
                                  Text(
                                      globalDeaths,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold
                                          )
                                      )
                                  )]
                            ),
                            Column(
                                children: <Widget>[
                                  Text(
                                    'Total Recoveries',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          fontSize: 20
                                        )
                                    ),
                                  ),
                                  Text(
                                      globalRecovered,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold
                                          )
                                      )
                                  )]
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Most Cases',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 20
                                      )
                                  )
                                ),
                                Container(
                                  width: 100,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(affectedCountryData[0]['countryInfo']['flag'])
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                Text(
                                  mostAffectedCountry,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 14
                                      )
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                    'Most Recoveries',
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 20
                                        )
                                    )
                                ),
                                Container(
                                  width: 100,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(recoveredCountryData[0]['countryInfo']['flag'])
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                Text(
                                  mostRecoveredCountry,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 14
                                      )
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.blue,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: null),
            new IconButton(icon: new Icon(Icons.map), onPressed: null),
            new IconButton(icon: new Icon(Icons.info), onPressed: null)
          ],
        ),
      ),
    );
  }
}
