import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';




main(){

  runApp(MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget{
  @override
  State createState() {
    return new _HomeState();
  }

}

class _HomeState extends State<Home> {
  var _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Persistent txt"),),
      body: Column(
        children: <Widget>[
          Center(
            child: FutureBuilder(future: readData(),
            builder: (BuildContext context, AsyncSnapshot<String> data){
              if(data.hasData){
                return Text(data.data);
              }else{
                return Text("No data yet");
              }
            },),
          ),
          Center(
              child: new TextField(
                controller: _textController,
                decoration: InputDecoration(
                    labelText: "String to save"
                ),
              )
          ),
          new Center(
            child: RaisedButton(
              onPressed: () {
                writeMyFile(_textController.text);
              },
              child: Text("save"),),
          )
        ],
      ),
    );
  }
}
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    print(path);
    return File('$path/myFile.txt');
  }

  Future<File> writeMyFile(String s) async{
    final file = await _localFile;

    return file.writeAsStringSync(s);
  }

  Future<String> readData() async{
    try{
    final file = await _localFile;
    String text = await file.readAsString();
    print(text);
    return text;}
    catch(e){
      return "";
    }
  }



