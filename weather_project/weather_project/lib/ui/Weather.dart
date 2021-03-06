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

String _city = utils.defautCity;

  Future _getCity(BuildContext context) async{
    Map result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
      return new ChangeCity();
      })

    );
    if(result!=null&&result.containsKey("city")){
        _city = result['city'];
    }else {
      _city = utils.defautCity;
    }
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
              onPressed: (){_getCity(context);})
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
              child: updateWeatherIcon(_city),
          alignment: Alignment.topRight,
          margin: const EdgeInsets.fromLTRB(0.0, 20.0, 40.0, 0.0),),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 66.0, 16.0, 0.0),
            child: Text("${_city==null?"curitiba":_city.replaceAll("+", " ")}",style: cityStyle()),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: updateTempWidget("${_city/*==null?"curitiba":_city*/}"),


            margin: const EdgeInsets.fromLTRB(16.0, 90.0, 0.0, 0.0)

          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String apiId,String city) async{

    //String apiURL = "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=$apiId&lang=pt&&unit=metric&&q=$city&units=metric";
    String apiURL = "http://api.openweathermap.org/data/2.5/weather?APPID=$apiId&lang=pt&units=metric&q=${city}";
    http.Response response = await http.get(apiURL);

    return json.decode(response.body);
  }


  Widget updateWeatherIcon(String city){
    return FutureBuilder(future: getWeather(utils.appId, city),
    builder: (BuildContext context, AsyncSnapshot<Map> data){

        if(data.hasData){
          Map content = data.data;
          return new Image.network(utils.getIcon(content['weather'][0]['icon']));
        }else {
          return Container();
        }

    },);
  }


  Widget updateTempWidget(String city){
    return FutureBuilder(
        future: getWeather(utils.appId, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
      if(snapshot.hasData){
        Map content = snapshot.data;
        return new Container(
          alignment: Alignment.centerLeft,

          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("${content['weather'][0]['description']}",
                    style: cityStyle(),),
                subtitle: new Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 8.0, 0.0, 0.0),
                  child: Text("Temperatura: ${content['main']['temp'].toString().replaceAll(".", ",")} ºC\n"
                      "Min: ${content['main']['temp_min'].toString().replaceAll(".", ",")} ºC\n"
                      "Max: ${content['main']['temp_max'].toString().replaceAll(".", ",")} ºC", style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),),
                ),

              )

            ],
          ),
          margin: const EdgeInsets.fromLTRB(0.0, 190.0, 80.0, 0.0),
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



class ChangeCity extends StatelessWidget {
  var _cityControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose your city"),
      backgroundColor: Colors.red.shade600,),
      body: Stack(
        children: <Widget>[
          new Image.asset("images/white_snow.png",
          width: 490.0,
          fit: BoxFit.fill,),
          ListView(
            children: <Widget>[
              Padding(padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "City"
                  ),
                  controller: _cityControler,
                  keyboardType: TextInputType.text,
                ),),
              Padding(padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  child: Text("Save"),
                  onPressed: (){
                    Navigator.pop(context,{
                      'city':_cityControler.text
                    });
                  },
                ),)
            ],
          )

        ],
      ),
    );
  }
}
