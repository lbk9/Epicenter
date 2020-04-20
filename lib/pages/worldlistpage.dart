import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class WorldList extends StatefulWidget {
  @override
  _WorldListState createState() => _WorldListState();
}

class _WorldListState extends State<WorldList> {
  List countryList;
  fetchWorldWideData() async {
    Response response = await get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryList = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'World List',
        ),
      ),
      body: ListView.builder(
        itemCount: countryList.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 1.0, right: 8.0, bottom: 1.0),
            child: Card(
              child: ListTile(
                title: Text(
                  countryList[index]['country'],
                  style: GoogleFonts.lato(
                    fontSize: 14
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    countryList[index]['countryInfo']['flag']
                  )
                ),
                trailing: Column(
                  children: <Widget>[
                    new Text(
                      'Confirmed:' + countryList[index]['cases'].toString(),
                      style: TextStyle(
                        color: Colors.amber
                      ),
                    ),
                    Text(
                      'Deaths: ' + countryList[index]['deaths'].toString(),
                      style: TextStyle(
                          color: Colors.red
                      ),
                    ),
                    Text(
                      'Recovered: ' + countryList[index]['recovered'].toString(),
                      style: TextStyle(
                          color: Colors.green
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
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
