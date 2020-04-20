import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Important Information'
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
                'Common Symptoms',
                style: GoogleFonts.lato(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
          Text(
            'There are a number of common symptoms of COVID-19 such as;',
            style: GoogleFonts.lato(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Colors.grey[500]
            ),
          )
        ],
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
