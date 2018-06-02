import 'package:flutter/material.dart';

class myPlanet extends StatefulWidget {
  @override
  State createState() {
    return myPlanetState();
  }
}

class myPlanetState extends State<myPlanet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weight on X planet"),
        backgroundColor: Colors.black38,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        alignment: Alignment.topCenter,
        margin: new EdgeInsets.all(8.0),
        //color: Colors.green,
        child: ListView(
          children: <Widget>[
            new Image.asset(
              'images/planet.png',
              height: 133.0,
              width: 200.0,
            ),
            Container(
              padding: EdgeInsets.all(6.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: null,
                    decoration: InputDecoration(
                      labelText: "Yout weight on Earth",
                      hintText: "in KGs",
                      icon: Icon(Icons.accessibility_new)

                    ),
                    keyboardType: TextInputType.number,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
