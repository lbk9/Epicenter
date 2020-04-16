import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert';

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
    Response response = await get('https://corona.lmao.ninja/all');
    worldData = json.decode(response.body);
    setState(() {
      globalCases = 'Global Cases ${worldData['cases']}';
      globalDeaths = 'Global Deaths ${worldData['deaths']}';
      globalRecovered = 'Global Recovered ${worldData['recovered']}';
    });
  }

  List countryData;
  String mostAffectedCountry;
  fetchCountryData() async {
    Response response = await get('https://corona.lmao.ninja/countries?sort=cases');
    countryData = json.decode(response.body);
    setState(() {
      countryData = json.decode(response.body);
      mostAffectedCountry = 'Most affected country ${countryData[0]['country']}';
    });
  }

    @override
    void initState() {
      fetchWorldWideData();
      fetchCountryData();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 1,
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(150, 70),
                    bottomLeft: Radius.elliptical(150, 70)),
                child: Container(
                  color: Colors.blue,
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
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Common Symptoms',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
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
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
              child: Card(
                color: Colors.grey,
                child: Container(
                  height: 250,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            mostAffectedCountry,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              countryData[0]['countryInfo']['flag']
                            ),
                          )
                        ],
                      ),
                      Text(
                        globalCases,
                        style: TextStyle(
                            fontSize: 18,
                          color: Colors.yellow
                        ),
                      ),
                      Text(
                          globalDeaths,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.red
                        ),
                      ),
                      Text(
                          globalRecovered,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green
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
