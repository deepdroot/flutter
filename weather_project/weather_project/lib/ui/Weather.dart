import 'dart:async';
import 'dart:convert';
import 'package:weather_project/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  Future<Map> showStuff() async{
    Map data = await getWeather(utils.appId,utils.defautCity);

    print(data['list'][0]['main']['temp']);
    print(data['list'][0]['weather'][0]['icon']);

    return data['list'][0];
    }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather 2.0", style: TextStyle(
          color: Colors.grey.shade50
        ),),
        backgroundColor: Colors.red.shade600,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.menu,),
              onPressed: showStuff)
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/umbrella.png',
            width: 490.0,
              fit: BoxFit.fill,),
          ),
          new Container(
              child: new Image.network(utils.getIcon("10n")),
          alignment: Alignment.topRight,
          margin: const EdgeInsets.fromLTRB(0.0, 20.0, 40.0, 0.0),),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 66.0, 16.0, 0.0),
            child: Text("Curitiba",style: cityStyle()),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: updateTempWidget("curitiba"),


            margin: const EdgeInsets.fromLTRB(16.0, 90.0, 0.0, 0.0)

          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String apiId,String city) async{
    //String apiURL = "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=$apiId&lang=pt&&unit=metric&&q=$city&units=metric";
    String apiURL = "http://api.openweathermap.org/data/2.5/weather?APPID=$apiId&lang=pt&units=metric&q=$city";
    http.Response response = await http.get(apiURL);

    return json.decode(response.body);
  }

  Widget updateTempWidget(String city){
    return FutureBuilder(
        future: getWeather(utils.appId, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
      if(snapshot.hasData){
        Map content = snapshot.data;
        return new Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("${content['weather'][0]['description']}",
                    style: cityStyle(),),


              )
            ],
          ),
          margin: const EdgeInsets.fromLTRB(0.0, 190.0, 180.0, 0.0),
        );
      }else{
        return new Center(child: new CircularProgressIndicator());
      }
    });
  }

}

TextStyle cityStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 26.0,
    fontWeight: FontWeight.w500
  );
}
