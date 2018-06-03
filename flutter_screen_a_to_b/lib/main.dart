import 'dart:async';

import 'package:flutter/material.dart';


main()=>runApp(MaterialApp(
  title: "Screen to Screen",
  home: new Home(),
));

class Home extends StatefulWidget{
  @override
  State createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<Home>{
  var _nameControler = TextEditingController();

  Future _gotResult(BuildContext context) async {
    Map results = await Navigator.of(context).push(
     new MaterialPageRoute(builder: (BuildContext context){
     return new Screen2(name: _nameControler.text,);
     })
    );

    if(results!=null&&results.containsKey("info")){
      print(results['info']);
      _nameControler.text = results['info'].toString();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screan A"),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: TextField(
              controller: _nameControler,
              decoration: InputDecoration(
                labelText: "Enter your name"
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: RaisedButton(
              onPressed: (){_gotResult(context);    },

              child: Text("Send to next screen", style: TextStyle(color: Colors.white),),
              color: Colors.blueAccent,
              elevation: 4.0,
            ),
          )
        ],
      )
    );
  }
}


class Screen2 extends StatefulWidget {
  String name;


  Screen2({Key key,this.name}):super(key:key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  var _name1Controler = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Screan B"),
          backgroundColor: Colors.green,
        ),
        body: ListView(
          children: <Widget>[
              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 26.0, 0.0, 0.0),
                child: Center(
                  child: Text("${widget.name}")
                ),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                child: TextField(
                  controller: _name1Controler,
                  decoration: InputDecoration(
                      labelText: "Enter your name"
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                child: RaisedButton(
                  onPressed: (){
                    Navigator.pop(context,{
                      'info':_name1Controler.text
                    });
                  },

                  child: Text("Send to next screen", style: TextStyle(color: Colors.white),),
                  color: Colors.blueAccent,
                  elevation: 4.0,
                ),
              )

          ],
        )
    );
  }
}
