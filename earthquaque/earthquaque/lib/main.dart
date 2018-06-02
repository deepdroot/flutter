import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Map _quakes;
List _features;
main() async {
  _quakes = await getQuakes();
  _features = _quakes['features'];
  print(_quakes['features'][0]['properties']['time']);

  runApp(new MaterialApp(
    title: "EarthQuake Indicator",
    color: Colors.orange,
    home: new Quakes(),
  ));
}

class Quakes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('EarthQuaque Indicator'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: new ListView.builder(
            itemCount: _features.length,
            padding: EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int position) {
              //creating the rows
              var date = new DateTime.fromMillisecondsSinceEpoch(_features[position]['properties']['time']);
              var formatter = new DateFormat('dd/MM/yyyy HH:mm');
              var fDate = formatter.format(date);

              return new Card(
                child: new ListTile(
                  title: new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Magnitude ${_features[position]['properties']['mag']} $fDate",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  subtitle: new Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                    child: Text(
                      "${_features[position]['properties']['place']}",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  leading: new CircleAvatar(
                    backgroundColor: _features[position]['properties']['mag'] <
                            1
                        ? Colors.green
                        : _features[position]['properties']['mag'] >= 1 &&
                                _features[position]['properties']['mag'] <= 3
                            ? Colors.yellow
                            : _features[position]['properties']['mag'] > 3 &&
                                    _features[position]['properties']['mag'] <=
                                        5
                                ? Colors.orange
                                : Colors.red,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "${_features[position]['properties']['mag'].toStringAsFixed(1)}",
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: (){
                    _showAlertDialog(context,_features[position]['properties']);
                  },
                ),
              );
            }),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, featur) {
    var alert = new AlertDialog(title: Text("${featur['type']}"),
     // content: Text("teste ${featur['geometry']['coordinates'][1]}\n${featur['geometry']['coordinates'][0]}"),
    actions: <Widget>[new FlatButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))],
    );
    showDialog(context: context,builder: (dialog)=>alert);
  }
}



Future<Map> getQuakes() async {
  String url =
      "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.geojson";
  http.Response response = await http.get(url);

  return json.decode(response.body);
}
