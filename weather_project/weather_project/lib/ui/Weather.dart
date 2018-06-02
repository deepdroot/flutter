import 'package:flutter/material.dart';


class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather 2.0", style: TextStyle(
          color: Colors.blue.shade700
        ),),
        backgroundColor: Colors.white,
        actions: <Widget>[],
      ),
    );
  }
}


