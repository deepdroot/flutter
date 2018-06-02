import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

main() async {
  List _data = await getJson();

  /*for(int i=0; i<_data.length;i++){
    print("odo a data! ${_data[i]}");
  }*/

  List _data2 = await getJson1();
  for(var i in _data2){
    print(i['address']['geo']);


  }

  String _body = _data[1]['body'];



  runApp(new MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text("Json Parse"),
      centerTitle: true,
      backgroundColor: Colors.orange,
    ),
    body: Center(
      child: new ListView.builder(
        itemCount: _data.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder:(BuildContext context,int position){
          if(position.isOdd)return Divider();
          var index = position~/2;
          return ListTile(
            title: Text(_data[index]['title'],style:TextStyle(
              fontSize: 18.9,
              color: Colors.green.shade700
            ),),
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text("${_data[index]['id']}"),
              ),
            onTap: (){_showDialog(context, _data[index]['body']);},
          );
        },

      ),
    ),
  ),
));
}

_showDialog(BuildContext context,String message){

  var alert = new AlertDialog(
    title: Text("Meu app"),
    content: Text("$message"),
    actions: <Widget>[
      new FlatButton(onPressed: (){Navigator.pop(context);},
          child: Text('OK'))
    ],
  );
  showDialog(context: context,barrierDismissible: false,builder: (teste)=> alert);
}

Future<List> getJson() async{
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  String apiUrl2 = 'https://jsonplaceholder.typicode.com/users';

  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}


Future<List> getJson1() async{
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  String apiUrl2 = 'https://jsonplaceholder.typicode.com/users';

  http.Response response = await http.get(apiUrl2);
  return json.decode(response.body);
}






class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

String _test(){
  print("this");
}