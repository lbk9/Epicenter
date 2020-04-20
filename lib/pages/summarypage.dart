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
  String globalCases;
  String globalDeaths;
  String globalRecovered;
  String globalActive;

  fetchWorldWideData() async {
    Response response = await get('https://corona.lmao.ninja/v2/all');
    worldData = json.decode(response.body);
    setState(() {
      globalCases = '${worldData['cases']}';
      globalDeaths = '${worldData['deaths']}';
      globalRecovered = '${worldData['recovered']}';
      globalActive = '${worldData['active']}';
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
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 5, right: 30, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.sentiment_very_dissatisfied,
                      size: 70,
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.whatshot,
                      size: 70,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    elevation: 8,
                    child: Container(
                      width: 150,
                      height: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            affectedCountryData[0]['countryInfo']['flag'],
                            height: 40,
                          ),
                          Text(
                            'Most Cases',
                            style: GoogleFonts.lato(
                              fontSize: 15
                            ),
                          ),
                          Text(
                            affectedCountryData[0]['cases'].toString(),
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8,
                    child: Container(
                      width: 150,
                      height: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            recoveredCountryData[0]['countryInfo']['flag'],
                            height: 40,
                          ),
                          Text(
                            'Most Recoveries',
                            style: GoogleFonts.lato(
                              fontSize: 15
                            ),
                          ),
                          Text(
                            recoveredCountryData[0]['recovered'].toString(),
                              style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic
                              )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 0),
              child: GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2.2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 8,
                      color: Colors.amber[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Cases',
                            style: GoogleFonts.lato(
                              color: Colors.amber[700],
                              fontSize: 16
                            ),
                          ),
                          Text(
                            globalCases,
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.amber[700],
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 8,
                      color: Colors.blue[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Active',
                            style: GoogleFonts.lato(
                                color: Colors.blue[700],
                                fontSize: 16
                            ),
                          ),
                          Text(
                            globalActive,
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 8,
                      color: Colors.green[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Recoveries',
                            style: GoogleFonts.lato(
                                color: Colors.green[700],
                                fontSize: 16
                            ),
                          ),
                          Text(
                            globalRecovered,
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 8,
                      color: Colors.red[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Deaths',
                            style: GoogleFonts.lato(
                                color: Colors.red[700],
                                fontSize: 16
                            ),
                          ),
                          Text(
                            globalDeaths,
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.red[700],
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.blue,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: null),
            new IconButton(icon: new Icon(Icons.public), onPressed: null),
            new IconButton(icon: new Icon(Icons.info), onPressed: null)
          ],
        ),
      ),
    );
  }
}
