import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

main() async {
  var data = readFile();
  if(data!=null)
  print('${data}');
  runApp(MaterialApp(
    title: "Persistent 1.0",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<Home> {
  var _newText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                controller: _newText,
                  decoration: InputDecoration(
                    labelText: "Text to save",
                    labelStyle: TextStyle(
                      color: Colors.red,

                    )
                  ),
            ),
              ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Save!"),
                onPressed: (){
                  writeData(_newText.text);
                },
              ),
            ),
              new Padding(
                padding: const EdgeInsets.all(48.0),
                child: Text("teste"),
              )
            ],

          ),
        ),
      ),
    );
  }



}


Future<String> get _localpath async{
  final diretory = await getTemporaryDirectory();
  return diretory.path;//home/directory
}

Future<File> get _localFile async{
  final path = await _localpath;
  return new File("$path/data.txt"); //home/directory/data.txt

}

//read and write
Future<File>writeData(String message)async{
  final file = await _localFile;
  return file.writeAsString(message);
}

Future<String>readFile() async{
  try{
    final file = await _localFile;
    return file.readAsString();
  }catch(e){

    print(e.toString());
    return "nothing there!";
  }
}

