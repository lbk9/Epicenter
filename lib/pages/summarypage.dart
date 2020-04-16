import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  Map worldData;
  String globalCases;
  fetchWorldWideData() async {
    Response response = await get('https://corona.lmao.ninja/all');
    worldData = json.decode(response.body);
    setState(() {
      globalCases = worldData['cases'].toString();
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
      body: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Center(
                child: Text(
                  globalCases
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
