import 'package:flutter/material.dart';
import 'dart:math';


main() => runApp(MaterialApp(
  title: "BMI",
  home: new Home(),
));

class Home extends StatefulWidget{
  @override
  State createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home>{
  var _height = TextEditingController();
  var _weight = TextEditingController();
  var imc = 0.0;



  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("BMI"),
        backgroundColor: Colors.purpleAccent,
      ),
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: <Widget>[
          Center(
            child: new Image.asset('images/bmilogo.png',
              height: 100.0,

            ),
          ),
          Padding(padding: EdgeInsets.all(8.0),),
          Container(
            margin: EdgeInsets.all(16.0),
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(decoration: InputDecoration(
                    icon: Icon(Icons.accessibility),
                    labelText: "Height"


                ),
                  controller: _height,
                  //keyboardType: TextInputType.number,
                ),
                TextField(decoration: InputDecoration(
                    icon: Icon(Icons.line_weight),
                    labelText: "Weight",



                ),onSubmitted: _calculateBIM,
                  controller: _weight,
                 // keyboardType: TextInputType.number,
                ),
                new Padding(padding: EdgeInsets.all(16.0)),
                Text("BMI: ${imc==0?"":imc}",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
                ),),
                Padding(padding: EdgeInsets.all(8.0),
                child: Text("${imc==0?"":imc<16&&imc>0?"Extremely Skinny":imc<17&&imc>=16?"Moderate Skinny":imc<18.5&&imc>=17?
                "Light Skinny":imc<25&&imc>=18?"Heathy!! Congratulations":imc<30&&imc>=25?"Overweight":imc<35&&imc>=30?"Super Weight":
                "You will die fat"}",
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),),)
              ],
            ),
          )
        ],
      ),
    );
  }

  double _calculateBIM(String value) {
    setState(() {
      imc = 1.72*double.parse(_weight.text)/pow(double.parse(_height.text), 3.06);

    });
  }
}